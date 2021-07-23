Rails.application.routes.default_url_options[:host] = ENV.fetch("APPLICATION_HOST", "localhost:3000")

Rails.application.routes.draw do
  namespace :admin do
    resources :jumio_identity_verifications
    resources :users

    root to: "users#index"
  end

  resources :sharing_events, only: :show, param: :uuid do
    resources :sharing_event_codes, only: :create
    get "download", to: "downloads#show"
  end

  post "/graphql", to: "graphql#execute"
  post "/callbacks/jumio", to: "jumio_identity_verifications#create"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
