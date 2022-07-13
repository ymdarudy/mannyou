Rails.application.routes.draw do
  root "users#new"
  resources :tasks
  resource :session
  resources :users, only: %i[new create show edit update]
  namespace :admin do
    root "users#index"
    resources :users
  end
end
