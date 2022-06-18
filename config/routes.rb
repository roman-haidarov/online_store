Rails.application.routes.draw do
  # devise_for :users

  resources :users
  resources :baskets do
    member do
      post :create_order
      delete :delete_from_basket
    end
  end

  resources :orders
  resources :items do
    member do
      post :add_to_basket
    end
  end
  
  resources :sessions, only: :create
end
