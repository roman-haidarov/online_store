class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy, :add_to_basket]

  def show
    render json: @item, status: 200
  end

  def create
    item = Item.new(item_params)
    
    if item.save
      render json: item, status: 201
    else
      render json: { errors: item.errors.full_message }, status: 400
    end
  end

  def add_to_basket
    current_user = User.find(params[:user_id])
    basket_item = BasketItem.new(basket_id: current_user.id, item_id: @item.id)

    if basket_item.save
      render json: { message: "item added to basekt" }, status: 200
    else
      render json: { errors: basket_item.errors.full_message }, status: 400
    end
  end

  def update
    if @item.update(item_params)     
      render json: @item, status: 200
    else
      render json: { errors: @item.errors.full_message }, status: 400
    end
  end

  def destroy
    if @item.destroy     
      render json: { message: "no content" }, status: 204
    else
      render json: { message: "user not deleted" }, status: 400
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end