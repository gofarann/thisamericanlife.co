Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api" do
      get '/random' => 'podcasts#random'
      get '/q' => 'podcasts#search'
      get '/:id' => 'podcasts#show'
      get '/' => 'podcasts#index'
    end
  end

  root 'podcasts#index'

  get '/import' => 'podcasts#import', as: :import
  get '/seed' => 'podcasts#seed', as: :seed
  get '/about' => 'podcasts#about', as: :about
  get '/search' => 'podcasts#search', as: :search
  get '/:id' => 'podcasts#show', as: :title

  namespace :admin do
    resources :episodes
  end

end
