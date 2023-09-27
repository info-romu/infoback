Rails.application.routes.draw do

  resources :cart_items
  resources :carts
  resources :items
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/profile/:id', to: 'profile#show', as: 'profile'
  post '/send_purchase_confirmation', to: 'user_mailer#purchase_confirmation'
  post '/send_email', to: 'contact#send_email'

  scope controller: :carts do
    post 'create_stripe_session', action: :create_stripe_session
  end

  get 'success', to: "carts#success"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end