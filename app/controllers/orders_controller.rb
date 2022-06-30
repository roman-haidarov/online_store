class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    user_orders = Order.where(user_id: params[:user_id])
    authorize user_orders

    render json: user_orders, status: 200
  end

  def destroy
    order = Order.find(params[:id])
    authorize order

    order.destroy

    render json: {}, status: 204
  end
end
