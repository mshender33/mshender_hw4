Rails.application.routes.draw do
  # Root directs to login page
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

  # Handle 404 errors with a custom page (optional)
  match "*path", to: "application#not_found", via: :all
end
