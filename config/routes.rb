Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
      get '/' => 'podcasts#index'
      get '/:id' => 'podcasts#show'
    end
  end

  root 'podcasts#index'

  resources :podcasts

  get '/import' => 'podcasts#import', as: :import
  get '/seed' => 'podcasts#seed', as: :seed
  get '/:id' => 'podcasts#show', as: :number

end
