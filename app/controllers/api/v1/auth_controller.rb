class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user!, only: [:me, :sign_out]

  # POST /api/v1/auth/sign_in
  def sign_in
    email = params[:email] || params.dig(:auth, :email)
    password = params[:password] || params.dig(:auth, :password)

    user = User.find_for_database_authentication(email: email)

    unless user&.valid_password?(password)
      return render json: { errors: ["Invalid email or password"] }, status: :unauthorized
    end

    token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    response.set_header("Authorization", "Bearer #{token}")

    render json: {
      token: token,
      user: {
        id: user.id,
        email: user.email,
        username: user.username
      }
    }, status: :ok
  end

  # POST /api/v1/auth/sign_up
  def sign_up
    user = User.new(sign_up_params)

    if user.save
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
      response.set_header("Authorization", "Bearer #{token}")

      render json: {
        token: token,
        user: {
          id: user.id,
          email: user.email,
          username: user.username
        }
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/auth/sign_out
  def sign_out
    render json: { message: "signed out" }
  end

  # GET /api/v1/auth/me
  def me
    render json: {
      id: current_user.id,
      email: current_user.email,
      username: current_user.username
    }, status: :ok
  end

  private

  def sign_up_params
    if params[:user].present?
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    else
      params.permit(:email, :username, :password, :password_confirmation)
    end
  end
end
