class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [ :edit, :update, :destroy]
  after_action :assign_delivery_partner, only: [:create, :update]

  def index
    if current_user.admin?
      @shipments = Shipment.all
    elsif current_user.customer?
      @shipments = current_user.shipments_as_customer
    elsif current_user.delivery_partner?
      @shipments = current_user.shipments_as_delivery_partner
    end
  end

  def user_shipments
    if current_user.admin?
      @shipments = Shipment.all
    else
      @shipments = Shipment.where(delivery_partner_id: current_user.id)
    end
  end

  def update_status
    @shipment = Shipment.find(params[:id])
    if @shipment.update(update_status_shipment_params)
      respond_to do |format|
        format.turbo_stream do 
          render turbo_stream: turbo_stream.replace("shipment_#{@shipment.id}_status", partial: 'shipment_status', locals: { shipment: @shipment })
        end
        format.html { redirect_back fallback_location: root_path } 
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error_notification', partial: 'shared/error_notification', locals: { message: @shipment.errors.full_messages.join(', ') }) }
        format.html { render :edit } # Render edit page if update fails
      end
    end
  end


  def show
  end

  def new
    if current_user.admin?
      @shipment = current_user.shipments_as_admin.build
    elsif current_user.customer?
      @shipment = current_user.shipments_as_customer.build
    elsif current_user.delivery_partner?
      @shipment = current_user.shipments_as_delivery_partner.build
    end
  end

  def edit
  end

  def create
    if current_user.admin?
      @shipment = current_user.shipments_as_admin.build(shipment_params)
    elsif current_user.customer?
      @shipment = current_user.shipments_as_customer.build(shipment_params)
    elsif
      @shipment = current_user.shipments_as_delivery_partner.build(shipment_params)
    end
    
    if @shipment.save
      redirect_to shipments_path
    else
      render :new
    end
  end

  def update
    if @shipment.update(shipment_params)
      redirect_to shipments_path
    else
      render :edit
    end
  end

  def destroy
    @shipment.destroy
    redirect_to shipments_path
  end

  private

  def set_shipment
    if current_user.admin?
      @shipment = Shipment.find(params[:id])
    elsif current_user.customer?
      @shipment = current_user.shipments_as_customer.find(params[:id])
    elsif current_user.delivery_partner?
      @shipment = current_user.shipments_as_delivery_partner.find(params[:id])
    end
  end

  def assign_delivery_partner
    target_location = params[:shipment][:target_location] 
    if target_location.present?
      closest_delivery_partner = User.find_by(role: 'delivery_partner', city: target_location)
      @shipment.update(delivery_partner_id: closest_delivery_partner.id) if closest_delivery_partner.present?
    end
  end

  def shipment_params
    params.require(:shipment).permit(:source_location, :target_location, :item, :status, :address)
  end

  def update_status_shipment_params
    params.require(:shipment).permit(:status)
  end
end