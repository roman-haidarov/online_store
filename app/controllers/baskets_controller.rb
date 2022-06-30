class BasketsController < ApplicationController
  before_action :authenticate!
  before_action :set_basket, only: [:show, :create_order, :delete_from_basket]

  def show
    render json: @basket.items, status: 200
  end

  def create_order
    items = Item.where(id: params[:item_ids])
    order = Order.new

    if items && order.valid?
      order.save
      basket_items = BasketItem.where(basket: @basket, item_id: params[:item_ids])
      basket_items.destroy_all
      order.items << items
      current_user.orders << order
      
      render json: { order: order, order_items: order.items }, status: 201
    else
      render json: { error: "something went wrong, please trie to again" }, status: 400
    end
  end

  def delete_from_basket
    basket_items = BasketItem.where(basket: @basket, item_id: params[:item_ids])
    basket_items.destroy_all

    render json: {}, status: 204
  end

  private

  def set_basket
    @basket = Basket.find(params[:id])

    authorize @basket
  end
end
