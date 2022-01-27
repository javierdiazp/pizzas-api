Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stores do
    resources :products, controller: 'stores_products', only: %i[index update destroy]
  end
  resources :orders, :products
end
