class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to root_path
    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  def secret
    if current_user.blank?
      render plain: '401 Unauthorized', status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :phone_number, :address, :role)
  end
end
