Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#index'
  get 'pages/secret'
  get 'users/secret'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create] 
  resources :shipments do 
    member do
      get 'shipments', to: 'shipments#user_shipments'
      patch 'update_status', to: 'shipments#update_status'
    end
  end
end
