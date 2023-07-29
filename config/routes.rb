Rails.application.routes.draw do
  root "pages#home"

  get "/projects/index", to: "projects#index", as: "projects_index"
end
