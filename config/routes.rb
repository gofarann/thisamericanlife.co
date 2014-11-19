Thisamericanmp3::Application.routes.draw do

  root 'podcasts#index'

  resources :podcasts

  get 'import' => 'podcasts#import', as: :import
  get 'podcasts/:number' => 'podcasts#show', as: :number

end
