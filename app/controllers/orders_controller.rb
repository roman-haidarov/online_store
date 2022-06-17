class OrdersController < ApplicationController
  def index
    render json: Order.all, status: 200
  end

  def create
    items = Item.where(id: params[:item_ids])
    order = Order.new

    if items && order.valid?
      order.save
      order.items << items
      
      render json: { order: order, order_items: order.items }, status: 201
    else
      render json: { error: "something went wrong, please trie to again" }, status: 400
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy

    render json: {}, status: 204
  end
end
