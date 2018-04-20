Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  root "static_pages#home"

  get "static_pages/home"
  get "static_pages/help"
  get "chats/index"

  # resources :conversations, only: :create do
  #   member do
  #     post :close
  #   end
    
  #   resources :messages, only: :create
  # end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"

  resources :users do
    member do
      get :following, :followers
    end
    resources :chats, only: [:index, :show, :create]
  end

  resources :microposts do
    resources :comments
  end

  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index destroy)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
  resources :messages, only:[:create]
end
