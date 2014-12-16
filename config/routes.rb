Thisamericanlife::Application.routes.draw do

  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
     resources :podcasts
    end
  end

  root 'podcasts#index'

  resources :podcasts

  get 'import' => 'podcasts#import', as: :import
  get 'podcasts/:number' => 'podcasts#show', as: :number

end
