class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user!, only: [:me, :sign_out]

  def sign_in
    user = User.find_for_database_authentication(email: params[:email])
    return render json: { error: "Invalid credentials" }, status: :unauthorized unless user&.valid_password?(params[:password])
    token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
    response.set_header('Authorization', "Bearer #{token}")
    render json: { user: { id: user.id, email: user.email, username: user.username } }
  end

  def sign_up
    user = User.new(email: params[:email], password: params[:password], username: params[:username])
    if user.save
      render json: { message: "ok" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_out
    # devise-jwt denylist is handled automatically by revocation strategy if you configure it
    render json: { message: "signed out" }
  end

  def me
    render json: { id: current_user.id, email: current_user.email, username: current_user.username }
  end
end
