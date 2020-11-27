Rails.application.routes.draw do
  get 'stripes/new'
  # post 'create_cart', to: 'carts#create', as: "create_cart"
  # get 'show/cart', to: 'carts#show', as: "show"
  get 'indentification/identification'
  devise_for :traders, :controllers => {:registrations => "registrations"}
  devise_for :users, :controllers => {:registrations => "registrations"}

  root to: "stores#index"
  get '/identification', to: 'identifications#identification', as: "identification"
  get '/dashboard', to: 'orders#dashboard', as: "dashboard"

  resources :stores do
    resources :products, only: [ :index, :new, :create ]
  end
  resources :products, only: [ :show, :edit, :update, :destroy]

  resources :carts, only: [:index, :create, :destroy]
  patch '/update_cart' => 'carts#update', as: "update_cart"

  scope '/checkouts' do
    get 'create/:store_id', to: 'checkouts#create_checkout'
    get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkouts#success', as: 'checkout_success'
    get 'checkout', to: 'checkouts#checkout', as: 'checkout'
  end

  get '/trader_person' => 'identifications#trader_person', as: :trader_person

  get '/trader_edit' => 'identifications#trader_edit', as: :trader_edit
  post '/trader_update' => 'identifications#trader_update', as: :trader_update

  get '/info' => 'identifications#info_stripe', as: :info
  post '/user_info' => 'identifications#user_info', as: :user_info

  get '/trader_info' => 'identifications#trader_info', as: :trader_info
  post '/trader_info_create' => 'identifications#trader_info_create', as: :trader_info_create

  get '/index_sub' => 'subscriptions#index', as: :index_sub
  post '/checkout_sub' => 'subscriptions#checkout_sub', as: :checkout_sub
  post '/webhook' => 'subscriptions#webhook', as: :webhook
  get '/delete_sub' => 'subscriptions#delete_sub', as: :delete_sub
  get '/success' => 'subscriptions#success', as: :success
  get '/checkout_session' => 'subscriptions#checkout_session', as: :checkout_session

end
