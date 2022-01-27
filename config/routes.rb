Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'orders#index'
  resources :orders do
    resources :products, controller: 'orders_products', only: %i[index]
  end
  resources :stores do
    resources :products, controller: 'stores_products', only: %i[index update destroy]
  end
  resources :products
end
