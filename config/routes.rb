Tent::Application.routes.draw do
  # Handle OPTIONS requests
  match '*all', to: 'application#cors', via: [:options]

  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  # General requests
  resources :posts, except: [:new, :edit], defaults: { format: 'json' }
  resources :tags, except: [:new, :edit], defaults: { format: 'json' }

  root to: 'posts#index'

  # Missing route catch-all
  match '*path', :to => 'application#routing_error', :via => :all, defaults: { format: 'json' }
end