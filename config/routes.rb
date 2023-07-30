Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'
  resources :users, only: [:show, :edit, :update]

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  resources :projects, only: [:index, :show, :edit, :update, :destroy]
  # get 'search', to: 'projects#index'
end
