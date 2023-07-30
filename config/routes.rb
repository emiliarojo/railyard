Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    # Add a custom route to handle updating individual fields
    # Other member routes...
  end

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  resources :projects, only: [:index, :show]
  # get 'search', to: 'projects#index'
end
