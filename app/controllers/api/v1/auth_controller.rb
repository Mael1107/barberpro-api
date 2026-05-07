class Api::V1::AuthController < ApplicationController
  before_action :authorize_request, only: [:me, :admin_test]
  before_action -> { authorize_role!(:admin) }, only: [:admin_test]
  def register
    user = User.new(user_params)

    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: user.as_auth_json }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: user.as_auth_json }
    else
      render json: { errors: "Invalid email or password" }, status: :unauthorized
    end
  end

  def me
    render json: @current_user.as_auth_json
  end

  def admin_test
    render json: { message: "You are admin! 👑" }
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end
end
