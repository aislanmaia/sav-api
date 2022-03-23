Rails.application.routes.draw do
  get 'clients/all'
  get 'clients/create'
  get 'clients/update'
  get 'clients/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/valid_token", to: "users#valid_token"
end
