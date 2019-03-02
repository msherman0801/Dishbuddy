class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.text :first_name
      t.text :last_name
      t.text :phone_number
      t.text :location
    end
  end
end
