Rails.application.routes.draw do
  root 'price_request#new'
  resources :price_request, only: [:new, :create]
end
