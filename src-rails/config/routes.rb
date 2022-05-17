Rails.application.routes.draw do

  resource :contracts

  post "/auth/login", to: "authentication#login"

  get "/contract/options", to: "options#index"
  get "/contract/options/:id", to: "options#show"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
end
