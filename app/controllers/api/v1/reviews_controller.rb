class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game

  def create
    review = @game.reviews.new(review_params.merge(user: current_user))
    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    review = current_user.reviews.find(params[:id])
    if review.update(review_params)
      render json: review
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.reviews.find(params[:id]).destroy!
    head :no_content
  end

  private
  def set_game; @game = Game.find(params[:game_id]); end
  def review_params; params.require(:review).permit(:rating, :comment); end
end
