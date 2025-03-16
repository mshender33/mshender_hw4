Rails.application.routes.draw do
  root "sessions#new"

  # User Authentication
  resources :users, only: [:new, :create]  # Sign-up page
  resources :sessions, only: [:new, :create, :destroy]

  # Custom Login/Logout Routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Places and Nested Entries
  resources :places do
    resources :entries, only: [:new, :create, :index, :show]  # Entries are nested inside places
  end
end
