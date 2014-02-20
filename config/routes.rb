Tent::Application.routes.draw do
  # Handle OPTIONS requests
  match "*all", to: 'application#cors', via: [:options]

  # General requests
  resources :posts, except: [:new, :edit], defaults: { format: 'json' }

  # Missing route catch-all
  match "*path", :to => "application#routing_error", :via => :all, defaults: { format: 'json' }
end