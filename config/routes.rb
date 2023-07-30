Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]
  resources :projects, only: [:index, :show]
  # get 'search', to: 'projects#index'
end
