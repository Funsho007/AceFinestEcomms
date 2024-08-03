Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  

  resources :products, only: [:index, :show]
  resource :cart, only: [:show]
  resources :orders, only: [:create, :update, :destroy]
  post '/orders/:id', to: 'orders#create', as: "order_items"
  post '/orders/:id', to: 'orders#update', as: "order_item"
  get '/category/:id', to: 'product_categories#show', as: "category"
  get '/about', to: 'home#about', as: "about"
  get '/contact_us', to: 'home#contact_us', as: "contact_us"
  get '/orders/checkout', to: 'orders#checkout', as: "checkout"
  get '/order/placed', to: 'orders#post_checkout', as: "post_checkout"
  get 'all_products', to: 'products#all_products', as: "all_products"
  get 'featured_products', to: 'products#featured_products', as: "featured_products"
  get 'recent_products', to: 'products#recent_products', as: "recent_products"

  namespace :admin do
    get 'home/index'
    get '/about', to: 'home#about'
  end

  resources :orders, only: [:index] # Add other actions as needed

  resources :payments
  root "home#index"
end
