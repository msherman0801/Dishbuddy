class Restaurant < ActiveRecord::Base
    has_many :user_restaurants
    has_many :users, through: :user_restaurants
end