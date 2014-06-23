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

  def import

    doc = Nokogiri::HTML(open('http://thisamericanlife.org')).css('div.this-week').css('div.content')

    newest = doc.css("h3").text.split(":").first.strip.to_i
    
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

        # image = doc.css("div.image img").attribute('src')
        # mp3 = "http://audio.thisamericanlife.org/jomamashouse/ismymamashouse/#{episode}.mp3"
      
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
