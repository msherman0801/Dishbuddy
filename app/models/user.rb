class User < ActiveRecord::Base
has_secure_password
has_many :friendships
has_many :user_restaurants
has_many :friends, through: :friendships, foreign_key: 'friend_id'
has_many :restaurants, through: :user_restaurants
end