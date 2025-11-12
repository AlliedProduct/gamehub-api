class Api::V1::LibraryItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    items = current_user.library_items.includes(:game)
    render json: items.as_json(include: :game)
  end

  def create
    item = current_user.library_items.new(li_params)
    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = current_user.library_items.find(params[:id])
    if item.update(li_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.library_items.find(params[:id]).destroy!
    head :no_content
  end

  private

  def li_params
    params.require(:library_item).permit(:game_id, :status)
  end
end
