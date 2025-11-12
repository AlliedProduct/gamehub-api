class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_game, only: [:show, :update, :destroy]

  def index
    page     = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 12

    scope = Game.order(created_at: :desc)
    count = scope.count
    games = scope.offset((page - 1) * per_page).limit(per_page)

    pages = (count.to_f / per_page).ceil
    nxt   = (page < pages) ? page + 1 : nil
    prv   = (page > 1) ? page - 1 : nil

    render json: {
      data: games,
      pagination: {
        page: page,
        items: per_page,
        count: count,
        pages: pages,
        next: nxt,
        prev: prv
      }
    }
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

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :platform, :genre, :release_year)
  end
end
