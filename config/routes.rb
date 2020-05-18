Rails.application.routes.draw do

  get "top_works/index"

  root to: 'top_works#index'

  resources :works

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user" 

  resources :users, only: [:index, :show]

  resources :works do 
    resources :votes, only: [:create]
  end
end
