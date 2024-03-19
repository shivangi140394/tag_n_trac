class UsersController < ApplicationController
  load_and_authorize_resource

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

  def show
    @user = User.find(params[:id])
    redirect_to root_path if @user.present?
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to root_path 
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def secret
    if current_user.blank?
      render plain: '401 Unauthorized', status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :phone_number, 
                                        :address, :role, :city, :state, :pincode)
  end
end
