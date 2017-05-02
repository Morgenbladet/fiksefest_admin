Rails.application.routes.draw do
  resources :things do
    collection do
      get :queue
    end
  end

  root to: "things#index"
end
