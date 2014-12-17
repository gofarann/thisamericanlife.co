class Api::PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show]

  def index
    podcasts = Podcast.order("number DESC").limit(10)
    render json: podcasts
  end

  def show
    render json: @podcast.to_json(methods: [:image, :podcast], except: [:id])
  end

  private

    def set_podcast
      @podcast = Podcast.find_by_number(params[:id])
    end

end
