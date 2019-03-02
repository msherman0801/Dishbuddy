class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :res_id
      t.text :name
      t.text :city_name
      t.text :address
      t.string :url
      t.string :photos_url
      t.string :user_rating
      t.string :user_votes
    end
  end
end
