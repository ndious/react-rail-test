Rails.application.routes.draw do

  resource :contracts

  post "/auth/login", to: "authentication#login"

  get "/contract/options", to: "options#index"
  get "/contract/options/:id", to: "options#show"

  get "/contract/archive", to: "archive#index"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
end
