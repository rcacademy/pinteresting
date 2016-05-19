Rails.application.routes.draw do
  resources :pins
  devise_for :users
  root 'home#index'
end
