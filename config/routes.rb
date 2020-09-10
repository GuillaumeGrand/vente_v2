Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get 'products/edit'
  get 'products/new'
  get 'products/delete'
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

end
