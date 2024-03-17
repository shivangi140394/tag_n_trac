class AddLocationFieldToShipment < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :address, :string
    remove_column :shipments, :status, :string
    add_column :shipments, :status, :integer
  end
end
