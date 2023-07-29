Rails.application.routes.draw do
  root "pages#home"

  resources :users, only: [:show, :edit, :update]
  get "/projects/index", to: "projects#index", as: "projects_index"
end
