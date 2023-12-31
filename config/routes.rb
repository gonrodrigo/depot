Rails.application.routes.draw do
  root 'store#index', as: 'store_index'

  resources :carts
  resources :line_items do
    member do
      post 'decrement'
    end
  end
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
