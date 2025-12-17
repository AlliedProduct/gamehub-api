class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game

  # POST /api/v1/games/:game_id/reviews
  def create
    review = Review.find_or_initialize_by(user: current_user, game: @game)
    review.assign_attributes(review_params)

    if review.save
      @game.recalc_avg_rating!
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
