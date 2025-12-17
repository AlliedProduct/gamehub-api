class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/games
  def index
    items = current_user.library_items.includes(:game).order(created_at: :desc)
    render json: items.map { |li| present(li) }, status: :ok
  end

  # GET /api/v1/games/:id
  def show
    li = current_user.library_items.includes(:game).find_by!(game_id: params[:id])
    render json: present(li), status: :ok
  end

  # POST /api/v1/games
  def create
    game = Game.find_or_create_by!(catalog_key) do |g|
      g.genre = game_params[:genre]
      g.release_year = game_params[:release_year]
    end

    li = current_user.library_items.new(
      game: game,
      status: game_params[:status],
      rating: game_params[:rating],
      notes: game_params[:notes]
    )

    if li.save
      render json: present(li), status: :created
    else
      render json: { errors: li.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/games/:id
  def update
    li = current_user.library_items.find_by!(game_id: params[:id])

    if li.update(library_item_params)
      render json: present(li), status: :ok
    else
      render json: { errors: li.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/games/:id
  def destroy
    li = current_user.library_items.find_by!(game_id: params[:id])
    li.destroy
    head :no_content
  end

  private

  def game_params
    params.require(:game).permit(
      :title,
      :platform,
      :genre,
      :release_year,
      :status,
      :rating,
      :notes
    )
  end

  def catalog_key
    {
      title: game_params[:title].to_s.strip,
      platform: game_params[:platform].to_s.strip,
      release_year: game_params[:release_year]
    }
  end

  def library_item_params
    params.require(:game).permit(:status, :rating, :notes)
  end

  def present(li)
    li.game.as_json(only: [ :id, :title, :platform, :genre, :release_year, :avg_rating ]).merge(
      "status" => li.status,
      "rating" => li.rating,
      "notes" => li.notes
    )
  end
end
