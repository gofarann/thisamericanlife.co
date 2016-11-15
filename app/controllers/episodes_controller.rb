class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

  def index
    @episodes = Episode.order("number DESC").page params[:page]
    @random_episode = Episode.find(rand(1..Episode.last.number))
  end

  def show
    @random_episode = Episode.find(rand(1..Episode.last.number))
  end

  def search
    response = Episode.search("#{params[:q]}*")
    @episodes = response.records.order(:title).to_a
  end

  def about
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, no_intra_emphasis: true, fenced_code_blocks: true, strikethrough: true)
  end

  def seed
    @episodes = Episode.order(:number).last(50)
    render layout: false
  end

  def local_resource_from_url(url)
    LocalResource.new(URI.parse(url))
  end

  def import
    # if new_episode?
    #
    #   episode = this_week
    #
    #   doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives/episode/#{episode}"))
    #
    #   content = doc.css("div#content")
    #   number = content.css("h1.node-title").text.split(":").first.to_i
    #   title = content.css("h1.node-title").text.split(":").last.strip
    #   description = content.css("div.description").text.strip
    #   date = Date.parse(content.css("div.date").text).strftime("%F")
    #
    #   # episode_acts = doc.css("ul#episode-acts")
    #   # acts_string = ""
    #   # doc.css("div.act-body > text()").first.text.gsub("\u2028", "").strip
    #   #
    #   # tags = doc.css("div.act-body").first.css("span.tags")
    #   # tags_string = "Tags: "
    #   # tags.each do |tag|
    #   #   tags_string << tag.text.strip
    #   #   tags_string << ", " unless tag.equal?(tags.last)
    #   # end
    #   #
    #   # contributors = doc.css("div.act-body").first.css("ul.act-contributors li")
    #   # contrtibutors_string = "Contributor: "
    #   # contrtibutors.each do |contrtibutor|
    #   #   contrtibutors_string << contrtibutor.text.strip
    #   #   contrtibutors_string << ", " unless contrtibutor.equal?(contrtibutors.last)
    #   # end
    #
    #   # image = "http:" + doc.css("div.image img").attribute('src').value
    #   # podcast = "http://podcast.thisamericanlife.org/podcast/#{episode}.mp3"
    #
    #   # begin
    #   #
    #   #   local_podcast = local_resource_from_url(podcast)
    #   #   local_copy_of_podcast = local_podcast.file
    #   #
    #   #   local_image = local_resource_from_url(image)
    #   #   local_copy_of_image = local_image.file
    #   #
    #   #   Aws::S3::Client.new.put_object(bucket: ENV['S3_BUCKET_NAME'], body: local_copy_of_podcast.path, key: "podcasts/#{episode}.mp3", acl: 'public-read')
    #   #   Aws::S3::Client.new.put_object(bucket: ENV['S3_BUCKET_NAME'], body: local_copy_of_image.path, key: "images/#{episode}.jpg", acl: 'public-read')
    #   #
    #   # ensure
    #   #
    #   #   local_copy_of_podcast.close
    #   #   local_copy_of_podcast.unlink
    #   #   local_copy_of_image.close
    #   #   local_copy_of_image.unlink
    #   #
    #   # end
    #
    #   Podcast.create!(number: number, title: title, description: description, date: date)
    #
    #   redirect_to root_path, notice: "New Episode Imported! :)"
    #
    # else
    #   redirect_to root_path, notice: "No New Episodes. :("
    # end
  end

  private

  def set_episode
    @episode = Episode.find_by_number(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:number, :title, :description, :date)
  end

end
