Rails.application.routes.draw do

  # /boards
  # /boards/:id
  resources :boards

  # full /pins resources
  resources :pins do
    resources :comments

    member do
      post '/repost' => 'pins#repost'
      get '/repost' => 'pins#show_repost'
    end

    member do
      post '/like' => 'pins#like'
    end
  end

  get '/:username' => 'users#show', as: 'user'

  devise_for :users
  root 'pins#index'
end
