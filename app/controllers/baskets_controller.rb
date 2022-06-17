class BasketsController < ApplicationController
  before_action :set_basket, only: :show

  def show
    render json: @basket.items, status: 200
  end

  private

  def set_basket
    @basket = Basket.find(params[:id])
  end
end
