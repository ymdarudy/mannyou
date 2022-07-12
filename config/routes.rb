Rails.application.routes.draw do
  root "users#new"
  resources :tasks
  resource :session
  resources :users
  namespace :admin do
    root "users#index"
    resources :users
  end
end
