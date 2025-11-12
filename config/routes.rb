Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  scope :api do
    namespace :v1 do
      post   "auth/sign_in",  to: "auth#sign_in"
      post   "auth/sign_up",  to: "auth#sign_up"
      delete "auth/sign_out", to: "auth#sign_out"
      get    "auth/me",       to: "auth#me"

      resources :games do
        resources :reviews, only: %i[create update destroy]
      end
      resources :library_items, only: %i[index create update destroy]
    end
  end
end
