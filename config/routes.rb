Rails.application.routes.draw do
  root 'locations#index'

  resource :locations, only: [:index] do
    get :compare
  end
end
