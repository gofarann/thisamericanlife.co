class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]
  
  require 'open-uri'
  
  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.order("number DESC").page params[:page]    
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
  end
  
  class LocalResource

    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def file
      @file ||= Tempfile.new(tmp_filename, tmp_folder, encoding: encoding).tap do |f|
        io.rewind
        f.write(io.read)
        f.close
      end
    end

    def io
      @io ||= uri.open
    end

    def encoding
      io.rewind
      io.read.encoding
    end

    def tmp_filename
      [
        Pathname.new(uri.path).basename,
        Pathname.new(uri.path).extname
      ]
    end

    def tmp_folder
      Rails.root.join('tmp')
    end

  end
  
  def local_resource_from_url(url)
    LocalResource.new(URI.parse(url))
  end

  def import
                
    doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives")).css("div#content").css("div#archive-episodes")
    newest_number = doc.css("li.first").css("h3").css("a").attribute("href").text.split("/")[3]
    raw_date = doc.css("li.first").css("h3").css("span.date").text.split(".")
    newest_date = Date.parse("#{raw_date[2]}-#{raw_date[0]}-#{raw_date[1]}")
    
    if newest_date > Date.today
      newest = newest_number.to_i - 1
    else
      newest = newest_number.to_i
    end
    
    last = Podcast.last.number
        
    if newest > last
      
      episode = last + 1
      
      while episode <= newest
            
        doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives/episode/#{episode}")).css("div#content")
    
        number = doc.css("h1.node-title").text.split(":").first.to_i
        title = doc.css("h1.node-title").text.split(":").last.strip
        description = doc.css("div.description").text.strip
        date = Date.parse(doc.css("div.date").text).strftime("%F")
    
        Podcast.create!(number: number, title: title, description: description, date: date)
    
        image = doc.css("div.image img").attribute('src')
        podcast = "http://audio.thisamericanlife.org/jomamashouse/ismymamashouse/#{episode}.mp3"

        begin
          local_podcast = local_resource_from_url(podcast)
          local_copy_of_podcast = local_podcast.file

          local_image = local_resource_from_url(image)
          local_copy_of_image = local_image.file

          s3 = AWS::S3.new
          
          podcast_key = "podcasts/#{episode}.mp3"
          s3.buckets["#{ENV['S3_BUCKET_NAME']}"].objects[podcast_key].write(:file => "#{local_copy_of_podcast.path}", :acl => :public_read)

          image_key = "images/#{episode}.jpg"
          s3.buckets["#{ENV['S3_BUCKET_NAME']}"].objects[image_key].write(:file => "#{local_copy_of_image.path}", :acl => :public_read)
        ensure
          local_copy_of_podcast.close
          local_copy_of_podcast.unlink
          local_copy_of_image.close
          local_copy_of_image.unlink
        end
      
        episode += 1
        
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
    
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find_by_number(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:number, :title, :description, :date)
    end
end
