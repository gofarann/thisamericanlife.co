class API::PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show]

  def index
    @podcasts = Podcast.order(:number).last(10).reverse
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
