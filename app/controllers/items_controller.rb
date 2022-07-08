class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy, :add_to_basket]
  before_action :authenticate!, except: [:index, :show]
  before_action :authorize_action, only: [:create, :update, :destroy]

  def index
    render json: Item.all, status: 200
  end

  def show
    render json: @item, status: 200
  end

  def create
    item = Item.new(item_params)
    
    if item.save
      render json: item, status: 201
    else
      render json: { errors: item.errors.full_messages }, status: 400
    end
  end

  def add_to_basket
    basket_item = BasketItem.new(basket: @current_user.basket, item: @item)

    if basket_item.save
      render json: { message: "item added to basekt" }, status: 201
    else
      render json: { errors: basket_item.errors.full_messages }, status: 400
    end
  end

  def update
    if @item.update(item_params)     
      render json: @item, status: 200
    else
      render json: { errors: @item.errors.full_messages }, status: 400
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

  def authorize_action
    authorize(nil, policy_class: ItemPolicy)
  end
end
