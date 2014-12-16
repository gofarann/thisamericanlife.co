class Api::PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show]

  def index
    @podcasts = Podcast.order("number DESC").page params[:page]
  end

  def show
    render json: @podcast.to_json(methods: [:image, :podcast])
  end

  private

    def set_podcast
      @podcast = Podcast.find_by_number(params[:id])
      @podcast.image = "http://#{ENV['S3_BUCKET_NAME']}/images/#{"%03d" % @podcast.number}.jpg"
      @podcast.podcast = "http://#{ENV['S3_BUCKET_NAME']}/podcasts/#{"%03d" % @podcast.number}.mp3"
    end

end
