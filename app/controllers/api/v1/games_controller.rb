class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :update, :destroy]

  # GET /api/v1/games
  def index
    games = current_user.games.order(created_at: :desc)
    render json: games, status: :ok
  end

  # GET /api/v1/games/:id
  def show
    render json: @game, status: :ok
  end

  # POST /api/v1/games
  def create
    @game = current_user.games.build(game_params)

    if @game.save
      render json: @game, status: :created
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/games/:id
  def update
    if @game.update(game_params)
      render json: @game, status: :ok
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/games/:id
  def destroy
    @game.destroy
    head :no_content
  end

  private

  def set_game
    @game = current_user.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(
      :title,
      :platform,
      :genre,
      :status,
      :rating,
      :notes
    )
  end
end
