ModelsSetupPlay::Application.routes.draw do
  get "home/index"

  resources :categories


  resources :offers


  resources :products


  devise_for :users

  root :to => "home#index"

  get '/search', to: 'application#search'

  get '/cat_show/:id', to: 'home#cat_show', as: 'cat_show'

  get '/add_first_item/:id', to: 'offers#add_first_item', as: 'add_first_item'
  get '/add/:id', to: 'offers#add', as: 'add'
  get '/accept/:id', to: 'offers#accept', as: 'accept'
  put '/finalize_offer/:id', to: 'offers#finalize_offer', as: 'finalize_offer'

end
