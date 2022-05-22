Rails.application.routes.draw do
  # Archives
  get "/archives", to: "archive#index"

  # Options
  get "/options", to: "options#index"
  get "/options/:id", to: "options#show"

  # Authentication
  post "/auth/login", to: "authentication#login"

  # Users
  get "/users", to: "users#index"
  post "/users", to: "users#create"
  get "/users/:id", to: "users#show"
  delete "/users/:id", to: "users#destroy"

  # Contracts
  get "/contracts", to: "contracts#index"
  post "/contracts", to: "contracts#create"
  post "/contracts/:id/cancel", to: "contracts#cancel"
  get "/contracts/:id", to: "contracts#show"
  put "/contracts/:id", to: "contracts#update"
  delete "/contracts/:id", to: "contracts#destroy"
end
