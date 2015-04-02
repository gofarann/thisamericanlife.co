class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]

  def index
    @podcasts = Podcast.order("number DESC").page params[:page]
    @random_podcast = Podcast.find(rand(1..Podcast.last.number))
  end

  def show
    @random_podcast = Podcast.find(rand(1..Podcast.last.number))
  end

  def api
  end

  def seed
    @podcasts = Podcast.order(:number).last(50)
    render layout: false
  end

  def local_resource_from_url(url)
    LocalResource.new(URI.parse(url))
  end

  def import

    if new_episode?

      episode = this_week

      doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives/episode/#{episode}")).css("div#content")

      number = doc.css("h1.node-title").text.split(":").first.to_i
      title = doc.css("h1.node-title").text.split(":").last.strip
      description = doc.css("div.description").text.strip
      date = Date.parse(doc.css("div.date").text).strftime("%F")

      image = doc.css("div.image img").attribute('src').value.insert(0, "http:")
      podcast = "http://podcast.thisamericanlife.org/podcast/#{episode}.mp3"

      begin
        local_podcast = local_resource_from_url(podcast)
        local_copy_of_podcast = local_podcast.file

        local_image = local_resource_from_url(image)
        local_copy_of_image = local_image.file

        s3 = AWS::S3.new
        bucket = s3.buckets["#{ENV['S3_BUCKET_NAME']}"]

        if !bucket.objects["podcasts/#{episode}.mp3"].exists?
          bucket.objects["podcasts/#{episode}.mp3"].write(:file => local_copy_of_podcast.path, :acl => :public_read)
        end

        if !bucket.objects["images/#{episode}.jpg"].exists?
          bucket.objects["images/#{episode}.jpg"].write(:file => local_copy_of_image.path, :acl => :public_read)
        end
      ensure
        local_copy_of_podcast.close
        local_copy_of_podcast.unlink
        local_copy_of_image.close
        local_copy_of_image.unlink
      end

      Podcast.create!(number: number, title: title, description: description, date: date)

      redirect_to root_path, notice: "New Episode Imported! :)"

    else
      redirect_to root_path, notice: "No New Episodes. :("
    end

  end

  private

    def set_podcast
      @podcast = Podcast.find_by_number(params[:id])
    end

    def podcast_params
      params.require(:podcast).permit(:number, :title, :description, :date)
    end

end
