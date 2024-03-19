class LocationsController < ApplicationController
  before_action :require_admin, except: [:index, :show, :new, :create]
  before_action :find_location, only: [:edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = "Location created successfully"
      redirect_to locations_path
    else
      flash[:alert] = "Location creation failed"
      render :new
    end
  end

  def edit
  end

  def show
    @location = Location.find(params[:id])
    redirect_to root_path if @location.present?
  end

  def update
    if @location.update(location_params)
      flash[:notice] = "Location updated successfully"
      redirect_to locations_path
    else
      flash[:alert] = "Location updated failed"
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:state, :city, :user_id)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def find_location
    @location = Location.find(params[:id])
  end
end
