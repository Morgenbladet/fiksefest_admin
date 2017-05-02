Rails.application.routes.draw do
  devise_for :users
  resources :things do
    collection do
      get :queue
    end
  end

  root to: "things#index"
end
