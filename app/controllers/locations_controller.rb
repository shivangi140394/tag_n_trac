class LocationsController < ApplicationController
  before_action :require_admin, except: [:index, :show, :new, :create]

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
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:notice] = "Location updated successfully"
      redirect_to locations_path
    else
      flash[:alert] = "Location updated failed"
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
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
end
