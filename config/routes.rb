Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api" do
      get '/random' => 'podcasts#random'
      get '/:id' => 'podcasts#show'
      get '/' => 'podcasts#index'
    end
  end

  root 'podcasts#index'

  resources :podcasts

  get '/import' => 'podcasts#import', as: :import
  get '/seed' => 'podcasts#seed', as: :seed
  get '/api' => 'podcasts#api', as: :api
  get '/:id' => 'podcasts#show', as: :title

end
