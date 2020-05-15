Rails.application.routes.draw do

  get "top_works/index"

  root to: 'top_works#index'

  resources :works
end
