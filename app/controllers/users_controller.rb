class UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])

    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    
    if user.save
      Basket.create(user_id: user.id)
      render json: user, status: 201
    else
      render json: { message: "user not created" }, status: 400
    end
  end

  def update
    user = User.find_by(id: params[:id])

    if user.update(user_params)     
      render json: user, status: 200
    else
      render json: { message: "user not updated" }, status: 401
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user.destroy     
      render json: { message: "no content" }, status: 204
    else
      render json: { message: "user not deleted" }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
