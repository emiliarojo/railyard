Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]
  get "/projects/index", to: "projects#index", as: "projects_index"
  # resources :projects
  # get 'search', to: 'projects#index'
end
