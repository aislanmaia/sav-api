class UsersController < ApplicationController
  before_action :authorized, except: [:login]

  def all
    result = ::UseCases::User::GetAll.new(params.merge(user: current_user)).call
    render_result result
  end

  def create
    result = ::UseCases::User::CreateUser.new(user_params.merge(user: current_user)).call
    serialize result, ::UserSerializer
  end

  def update
    result = ::UseCases::User::UpdateUser.new(user_params.merge(user: current_user)).call
    # render_result result
    serialize result, ::UserSerializer
  end

  def delete
    result = ::UseCases::User::DeleteUser.new(params.merge(user: current_user)).call
    render_result result
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
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
    params.permit(:id, :name, :firstname, :lastname, :email, :password, :password_confirmation, :registry, :role)
  end

end
