Rails.application.routes.draw do
  resources :pins do
    resources :comments
  end

  get ':username' => 'users#show', as: 'user'

  devise_for :users
  root 'pins#index'
end
