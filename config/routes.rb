Rails.application.routes.draw do
  # devise_for :users

  resources :users do
    resources :items
  end
end
