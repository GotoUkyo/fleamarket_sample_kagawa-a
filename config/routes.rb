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

  # resources :indexes, only: [:show] do
  #   collection do
  #     get 'show', to: 'indexes#show'
  #   end
  # end

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    member do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'purchase', to: 'items#purchase'
    end
    # routingにおけるcollectionとmemberの違いは生成するroutingに:idがつくかどうか
    # 参考URL：https://qiita.com/k152744/items/141345e34fc0095217fe
  end

  resources :credits, only: [:new, :show] do
    collection do
      post 'show', to: 'credits#show'
      post 'register', to: 'credits#register'
      post 'delete', to: 'credits#delete'
    end
    member do
      post 'buy', to: 'credits#buy'
    end
  end

  resources :users, only: [:show, :index] do
    collection do
      get 'index', to: 'users#index'
      get 'show', to: 'users#show'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
