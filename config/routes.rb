Rails.application.routes.draw do
  get 'stripes/new'
  # post 'create_cart', to: 'carts#create', as: "create_cart"
  # get 'show/cart', to: 'carts#show', as: "show"
  get 'indentification/identification'
  devise_for :traders
  devise_for :users

  root to: "stores#index"
  get '/identification', to: 'identifications#identification', as: "identification"
  get '/dashboard', to: 'orders#dashboard', as: "dashboard"

  resources :stores do
    resources :products, only: [ :index, :new, :create ]
  end
  resources :products, only: [ :show, :edit, :update, :destroy]
  resources :carts, only: [:index, :create, :update, :destroy]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

end
