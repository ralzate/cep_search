Rails.application.routes.draw do
  root :to => 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', :as => :signout
  get '/signin' => 'sessions#new', :as => :signin

  resources :searches, only: :create
end
