Rails.application.routes.draw do
  get 'reviews/create'
  get 'deals/create'
  get 'deals/update'
  get 'deals/show'
  get 'deals/index'
  get 'offers/create'
  get 'offers/update'
  get 'offers/destroy'
  get 'offers/edit'
  get 'items/create'
  get 'items/new'
  get 'items/update'
  get 'items/destroy'
  get 'items/edit'
  get 'items/show'
  get 'items/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
