class API::EpisodesController < ApplicationController

  def index
    page = params[:page].nil? ? 1 : params[:page].to_i

    newest = Episode.last.number

    start = page == 1 ? newest : newest - ((page - 1) * 10)
    stop = start - 9
    podcasts = (stop..start).to_a

    @episodes = Episode.where(number: podcasts).order(:number).reverse
    render json: @episodes
  end

  def show
    @episode = Episode.find_by(number: params[:id])
    render json: @episode
  end

  def random
    podcast = rand(1..Episode.last.number)
    @episode = Episode.find_by(number: podcast)
    render json: @episode
  end

  def search
    response = Episode.search("#{params[:q]}*")
    @episodes = response.records.order(:title).to_a
    render json: @episodes
  end


end
