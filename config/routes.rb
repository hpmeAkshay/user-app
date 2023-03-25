Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy]
  get '/typehead/:input', to: 'users#typehead'
  root "users#new"
end
