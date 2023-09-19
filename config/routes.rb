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
  namespace :api do
    namespace :v1 do
      resources :cart_items, only: [:create]
      resources :payments, only: [:create]
    end
end