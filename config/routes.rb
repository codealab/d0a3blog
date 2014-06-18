Blog::Application.routes.draw do

  get "subcategories/index"
  get "subcategories/show"
  get "categories/index"
  get "categories/show"
  get "post/index"
  get "post/show"
  get "post/new"
  root 'sessions#new'
  
  resources :users
  resources :posts
  resources :subcategories
  resources :categories do
    resources :subcategories
  end
  resources :users do
    resources :posts
  end
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]

  get "sessions/new"
  get "sessions/edit"
  get "sessions/create"
  get "sessions/destroy"

  match '/user',    to: 'users#show',           via: 'get'
  match '/edit',    to: 'users#edit',           via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  get ':controller(/:action(/:id))(.:format)'

end