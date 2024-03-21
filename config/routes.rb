Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  resources :items
  get 'myitems', to: 'items#my_items', as: :myitems
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
