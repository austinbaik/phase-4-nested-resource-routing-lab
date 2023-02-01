class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # def index
  #   items = Item.all
  #   render json: items, include: :user
  # end

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      # render_not_found_response
      items = Item.all
    end
    render json: items, include: :user
  end

  # there is a user_id 
  # there isn't a user_id and only /items

  def show
    user = User.find(params[:user_id])
    item = user.items.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(items_params)
    render json: item, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "user not found" }, status: :not_found
  end

  def items_params
    params.permit(:name, :description, :price)
  end

end
