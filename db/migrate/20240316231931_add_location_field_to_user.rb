class AddLocationFieldToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :pincode, :integer
  end
end
