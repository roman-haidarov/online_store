class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    render json: Order.all, status: 200
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy

    render json: {}, status: 204
  end
end
