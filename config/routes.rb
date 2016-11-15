Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api" do
      get '/random' => 'episodes#random'
      get '/q' => 'episodes#search'
      get '/:id' => 'episodes#show'
      get '/' => 'episodes#index'
    end
  end

  root 'episodes#index'

  get '/import' => 'episodes#import', as: :import
  get '/seed' => 'episodes#seed', as: :seed
  get '/about' => 'episodes#about', as: :about
  get '/search' => 'episodes#search', as: :search
  get '/:id' => 'episodes#show', as: :title

  namespace :admin do
    resources :episodes
  end

end
