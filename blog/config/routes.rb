Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  resources :comments
  resources :posts
  get 'home/index'

  root 'home#index' 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
