class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create]

  def show
    render json: @item, status: 200
  end

  def create
    @item = @user.items.new(item_params)
    
    if @item.save
      render json: @item, status: 201
    else
      render json: { errors: @item.errors.full_message }, status: 400
    end
  end

  def add_to_basket
    @item = @user.items.new(item_params)
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

  def set_basket
    set_item
    @basket = @item.
  end

  def set_item
    set_user
    @item = @user.items.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
