Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/home"
  get "static_pages/help"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments
  end

  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index destroy)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
