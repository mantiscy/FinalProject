ModelsSetupPlay::Application.routes.draw do
  get "home/index"

  resources :categories


  resources :offers
  get '/completed_offers', to: 'offers#completed_offers', as: 'completed_offers'

  resources :products


  devise_for :users

  root :to => "home#index"

  get '/search', to: 'application#search'

  get '/cat_show/:id', to: 'home#cat_show', as: 'cat_show'

  get '/add_first_item/:id', to: 'offers#add_first_item', as: 'add_first_item'
  get '/add/:id', to: 'offers#add', as: 'add'
  get '/accept/:id', to: 'offers#accept', as: 'accept'
  post '/finalize_offer', to: 'offers#finalize_offer', as: 'finalize_offer'
  get '/amend/:id', to: 'offers#amend', as: 'amend'

  resources :offers do
    get 'page/:page', action: :index, on: :collection
  end

end
