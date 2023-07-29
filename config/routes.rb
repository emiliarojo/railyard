Rails.application.routes.draw do
  root 'pages#home'
  resources :users, only: [:show, :edit, :update]
  # resources :projects
  # get 'search', to: 'projects#index'
end
