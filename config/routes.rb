Rails.application.routes.draw do
  namespace :api do
    resources :things, only: [:index, :show, :create] do
      resources :comments, only: [ :create ]
    end
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
