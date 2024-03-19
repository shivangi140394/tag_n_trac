class AddRefUserToShipment < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipments, :admin, foreign_key: { to_table: :users }
  end
end
