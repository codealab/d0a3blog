Blog::Application.routes.draw do

  root 'posts#index'
  
  resources :categories
  resources :sessions
  resources :media
  resources :post_types
  resources :users do
    resources :posts
  end

  resources :posts do
    resources :categories
  end

  resources :categories_post_types
  resources :password_resets
  resources :sessions, only: [ :new, :create, :destroy ]

  match '/user',    to: 'users#show',           via: 'get'
  match '/edit',    to: 'users#edit',           via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  get ':controller(/:action(/:id))(.:format)'

end