Rails.application.routes.draw do

  devise_for :users
  root to: "items#index"
  resources :items, except: :index
  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
end
  resources :offers, only: [:new, :create, :edit, :update, :destroy]
  resources :deals, only: [:index, :show, :create] do
    member do
      patch :cancel
    end
    resources :reviews, only: [:create]

  end
  resources :chatrooms, only: [:show, :create] do
    resources :messages, only: :create
  end

end
