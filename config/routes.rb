Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resource :users, only: [:create_session]
  post "/login", to: "users#login"
  get "/valid_token", to: "users#valid_token"

  scope :employees do
    get 'all' => 'users#all'
    post '/' => 'users#create'
    put '/:id' => 'users#update'
    delete '/:id' => 'users#delete'
  end

  scope :clients do
    get 'all' => 'clients#all'
    post '/' => 'clients#create'
    put '/:id' => 'clients#update'
    delete '/:id' => 'clients#delete'
  end
end
