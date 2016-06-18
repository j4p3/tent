TentApi::Application.routes.draw do
  # Handle OPTIONS requests
  match '*all', to: 'application#cors', via: [:options]

  match 'users', to: 'users/users#index', via: [:get], defaults: { format: 'json' }
  match 'users', to: 'users/users#create', via: [:post], defaults: { format: 'json' }
  match 'users/:id', to: 'users/users#show', via: [:get], defaults: { format: 'json' }
  match 'users/login', to: 'users/users#login', via: [:post], defaults: { format: 'json' }

  devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks' }
  # General requests
  resources :posts, except: [:new, :edit], defaults: { format: 'json' }
  resources :tags, except: [:new, :edit, :update], defaults: { format: 'json' }
  resources :tents, except: [:new, :edit]
  resources :interactions, except: [:new, :edit]

  root to: 'application#routing_error'

  # Missing route catch-all
  match '*path', :to => 'application#routing_error', :via => :all, defaults: { format: 'json' }
end