Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
      get '/:id' => 'podcasts#show', as: :number
    end
  end

  root 'podcasts#index'

  resources :podcasts

  get '/import' => 'podcasts#import', as: :import
  get '/:id' => 'podcasts#show', as: :number

end
