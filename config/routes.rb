Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  resources :items
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'

  scope controller: :carts do
    post 'create_stripe_session', action: :create_stripe_session
  end

  get 'success', to: "carts#success"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end