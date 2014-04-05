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

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end
  
  def import

    doc = Nokogiri::HTML(open('http://thisamericanlife.org')).css('div.this-week').css('div.content')

    this_week = doc.css("h3").text.split(":").first.strip.to_i

    if this_week > Podcast.last.number

      doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives/episode/#{this_week}")).css("div#content")

      image = doc.css("div.image img").attribute('src')
      number = doc.css("h1.node-title").text.split(":").first
      title = doc.css("h1.node-title").text.split(":").last.strip
      description = doc.css("div.description").text.strip
      date = Date.parse(doc.css("div.date").text).strftime("%F")
      mp3 = "http://podcast.thisamericanlife.org/podcast/#{this_week}.mp3"

      puts "Image: " + image
      puts "Number: " + number
      puts "Title: " + title
      puts "Description: " + 
      description
      puts "Date: " + date
      puts "MP3: " + mp3
      
      redirect_to root_path

    else

      puts "RE-RUN!"
      
      redirect_to root_path

    end
    
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render action: 'show', status: :created, location: @podcast }
      else
        format.html { render action: 'new' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
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
