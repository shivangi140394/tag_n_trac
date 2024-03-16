class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :password_confirmation
      t.string :username
      t.string :email
      t.string :address
      t.integer :phone_number
      t.integer :role

      t.timestamps
    end
  end
end
