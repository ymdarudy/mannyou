Rails.application.routes.draw do
  root "users#new"
  resources :tasks
  resource :session
  resources :users
end
