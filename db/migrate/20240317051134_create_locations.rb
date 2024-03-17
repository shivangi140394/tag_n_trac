class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :state
      t.string :city
      t.references :user

      t.timestamps
    end
  end
end
