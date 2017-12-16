Rails.application.routes.draw do
  devise_for :users
  root "restaurants#index"
  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end