Rails.application.routes.draw do
  namespace :api do
    resources :things, only: [:index, :show, :create]
  end

  devise_for :users
  resources :things do
    collection do
      get :queue
    end
  end

  root to: "things#index"
end
