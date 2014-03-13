ModelsSetupPlay::Application.routes.draw do
  get "home/index"

  resources :categories


  resources :offers


  resources :products


  devise_for :users

  root :to => "home#index"

  get '/search', to: 'home#search'

end
