Rails.application.routes.draw do
  root "sessions#new"  # Homepage directs to login

  # User Authentication
  resources :users, only: [:new, :create]  # Handles sign-up
  
  # Sessions (Login & Logout)
  resources :sessions, only: [:new, :create, :destroy]
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"

  # Places and Nested Entries
  resources :places do
    resources :entries, only: [:new, :create, :index, :show]  # Nested routes for entries under places
  end
end
