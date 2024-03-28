Rails.application.routes.draw do
  post "/create_user", to: "users#create", as: "create_user"

  devise_for :users
  root to: "pages#home"
  get 'users/:id', to: 'users#show', as: :user
  get 'profile', to: 'users#profile', as: :profile
  resources :items, except: [:destroy] do
    member do
      patch :hide
    end
  end
  get 'myitems', to: 'items#my_items', as: :myitems

    resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
end
  resources :offers, only: [:new, :show, :create, :edit, :update, :destroy] do
    member do
      patch :reject
      patch :cancel
    end
  end
  resources :deals, only: [:index, :show, :create] do
    member do
      patch :cancel
      patch :complete
    end
    resources :reviews, only: [:create]

  end
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: :create
  end
  resources :preferences, only: [:create, :destroy]

  # resources :users, only: [:create]
end
