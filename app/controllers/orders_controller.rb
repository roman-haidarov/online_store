class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    user_orders = Order.where(user_id: params[:user_id])
    data = policy_scope(user_orders)

    render json: data, status: 200
  end

  def destroy
    order = Order.find(params[:id])
    authorize order

    order.destroy

    render json: {}, status: 204
  end
end
