Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: :show
  root "restaurants#index"
  
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    get  :feeds, :on => :collection
    get  :dashboard, :on => :member
    post :favorite, :on => :member
    post :unfavorite, :on => :member
    post :like, :on => :member
    post :unlike, :on => :member
    get  :ranking, :on => :collection
  end

  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end