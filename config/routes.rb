Rails.application.routes.draw do
  # devise_for :users

  resources :users
  resources :items do
    member do
      post :add_to_basket
    end
  end
end
