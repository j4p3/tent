TentApi::Application.routes.draw do
  # Handle OPTIONS requests
  match '*all', to: 'application#cors', via: [:options]

  # match 'users', to: 'users/users#index', via: [:get], defaults: { format: 'json' }
  # match 'users', to: 'users/users#create', via: [:post], defaults: { format: 'json' }
  # match 'users/:id', to: 'users/users#show', via: [:get], defaults: { format: 'json' }
  

  # devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks' }

  # General requests
  match 'events', to: 'events#index', via: [:get], defaults: { format: 'json' }
  resources :posts, except: [:new, :edit], defaults: { format: 'json' }
  resources :tags, except: [:new, :edit, :update], defaults: { format: 'json' }
  resources :tents, except: [:new, :edit]
  resources :interactions, except: [:new, :edit]
  resources :subscriptions, only: [:index, :create, :destroy]
  resources :users, except: [:new], controller: 'users/users', defaults: { format: 'json' }
  match 'users/login', to: 'users/users#authenticate', via: [:post], defaults: { format: 'json' }

  root to: 'application#routing_error'

  # Missing route catch-all
  match '*path', :to => 'application#routing_error', :via => :all, defaults: { format: 'json' }
end