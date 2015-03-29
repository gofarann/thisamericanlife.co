class API::PodcastsController < ApplicationController

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
    @podcast = Podcast.find_by(number: params[:id])
    render json: @podcast
  end

  def random
    podcast = rand(1..Podcast.last.number)
    @podcast = Podcast.find_by(number: podcast)
    render json: @podcast
  end

end
