Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/valid_token", to: "users#valid_token"

  scope :clients do
    get 'all' => 'clients#all'
    post '/' => 'clients#create'
    put '/:id' => 'clients#update'
    delete '/:id' => 'clients#delete'
  end
end
