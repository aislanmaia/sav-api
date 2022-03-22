class UsersController < ApplicationController
  before_action :authorized, only: [:valid_token]

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: "Invalid username or password" }
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      entity_update_token(@user, token)
      render json: {
        id: @user.id,
        name: @user.username,
        email: @user.email,
        token: @user.token,
        type: @user.role,
        registry: @user.registry
      }
    else
      render json: { error: "Invalid username or password" }
    end
  end

  def valid_token
    render json: @user
  end

  private

  def entity_update_token(entity, auth_token)
    entity.token = auth_token
    entity.save!
  end

  def user_params
    params.permit(:name, :email, :password, :registry, :role)
  end

end
