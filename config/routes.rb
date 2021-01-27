Rails.application.routes.draw do
  devise_for :users
  root 'indexes#index'
  resources :items, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items
end