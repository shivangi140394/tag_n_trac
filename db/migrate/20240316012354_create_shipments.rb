class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.references :customer, foreign_key: { to_table: :users }
      t.references :delivery_partner, foreign_key: { to_table: :users }
      t.string :source_location
      t.string :target_location
      t.string :item
      t.string :status


      t.timestamps
    end
  end
end
