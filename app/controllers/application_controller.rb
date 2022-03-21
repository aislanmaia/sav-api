class ApplicationController < ActionController::API
  # TOKEN_KEY = ENV.fetch('TOKEN_SIGN_KEY')
  TOKEN_KEY = ENV['TOKEN_SIGN_KEY']

  def encode_token(payload)
    JWT.encode payload, TOKEN_KEY
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      # Bearer <example_token>
      token = auth_header.split(' ').last
      begin
        JWT.decode token, TOKEN_KEY, true, algorithm: 'HS256'
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token.first['user_id']
      @user = User.find_by id: user_id
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
