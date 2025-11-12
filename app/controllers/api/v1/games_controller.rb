class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_game, only: [:show, :update, :destroy]

  def index
    q = Game.ransack(params[:q]) # e.g. q[title_i_cont]=zelda
    pagy, games = pagy(q.result.order(created_at: :desc), items: (params[:per_page] || 12))
    render json: { data: games, pagination: pagy_metadata(pagy) }
  end

  def show
    render json: @game.as_json(include: { reviews: { include: :user } })
  end

  def create
    game = Game.new(game_params)
    if game.save
      render json: game, status: :created
    else
      render json: { errors: game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy!
    head :no_content
  end

  private
  def set_game; @game = Game.find(params[:id]); end
  def game_params
    params.require(:game).permit(:title, :platform, :genre, :release_year)
  end
end
