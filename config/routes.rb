Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'indexes#index'

  resources :items, only: [:index, :show, :new, :create] do
    collection do
      post 'show', to: 'items#show'
      post 'buy', to: 'items#buy'
    end
  end
  resources :credits, only: [:new, :show] do
    collection do
      post 'show', to: 'credits#show'
      post 'register', to: 'credits#register'
      post 'delete', to: 'credits#delete'
      post 'buy', to: 'credits#buy'
    end
  end

  resources :users, only: [:show] do
    collection do
      get 'show', to: 'users#show'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end