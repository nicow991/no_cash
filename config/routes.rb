Rails.application.routes.draw do

  devise_for :users
  root to: "items#index"
  resources :items, except: :index
  resources :offers, only: [:new, :create]
  resources :deals, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
    member do
      patch :cancel
    end
  end

end
