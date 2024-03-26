Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get 'profile', to: 'users#show', as: :profile
  resources :items
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
end
