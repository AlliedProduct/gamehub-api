Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions passwords]

  namespace :api do
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
