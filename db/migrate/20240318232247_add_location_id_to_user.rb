class AddLocationIdToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone_number, :integer
    add_column :users, :phone_number, :bigint
    add_reference :users, :location, foreign_key: true
  end
end
