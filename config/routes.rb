Rails.application.routes.draw do
  namespace :api do
    resources :comments, only: [ :show, :create ]
    resources :things, only: [:index, :show, :create]
  end

  devise_for :users
  resources :things do
    collection do
      get :queue
    end
  end

  resources :comments, only: [:update, :destroy]

  root to: "things#index"
end
