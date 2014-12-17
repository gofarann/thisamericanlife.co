Thisamericanlife::Application.routes.draw do

  root 'podcasts#index'

  resources :podcasts

  get '/import' => 'podcasts#import', as: :import
  get '/seed' => 'podcasts#seed', as: :seed
  get '/:id' => 'podcasts#show', as: :number

  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
      get '/:id' => 'podcasts#show', as: :number
    end
  end

end
