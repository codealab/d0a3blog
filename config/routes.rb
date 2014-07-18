Blog::Application.routes.draw do

  root 'posts#index'
  
  resources :categories
  resources :sessions
  resources :resources
  resources :post_types
  resources :tags do
    resources :posts
  end
  resources :users do
    resources :posts
  end

  resources :posts do
    resources :categories
    resources :resources
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