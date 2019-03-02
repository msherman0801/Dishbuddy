class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :res_id
      t.text :name
      t.text :city_name
      t.text :address
      t.string :url
      t.string :photos_url
      t.string :aggregate_rating
      t.string :votes
      t.text :locality
      t.text :latitude
      t.text :longitude
      t.string :rating_color
      t.text :phone_numbers
    end
  end
end