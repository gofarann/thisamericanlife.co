class API::PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show]

  def index
    page = params[:page].nil? ? 1 : params[:page].to_i

    newest = Podcast.last.number

    start = newest - (page * 10)
    stop = start + 10
    podcasts = (start..stop).to_a

    @podcasts = Podcast.where(number: podcasts).order(:number).reverse
    render json: @podcasts
  end

  def show
    render json: @podcast
  end

  private

  def set_podcast
    @podcast = Podcast.find_by_number(params[:id])
  end

end
