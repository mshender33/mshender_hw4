Rails.application.routes.draw do
  root "sessions#new"

  # User Authentication
  resources :users, only: [:new, :create]
  get "signup", to: "users#new", as: "signup"
  

  # Sessions (Login & Logout)
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"

  # Places and Nested Entries
  resources :places do
    resources :entries, only: [:new, :create, :index, :show]
  end
end
