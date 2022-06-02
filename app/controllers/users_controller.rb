class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    
    if user.save
      Basket.create(user_id: user.id)
      render json: user, status: 201
    else
      render json: { message: "user not created" }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
