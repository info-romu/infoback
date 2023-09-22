class Item < ApplicationRecord
    has_many :cart_items
    has_many :carts, through: :cart_items 

    validates_presence_of :name, :description, :price, :imageUrl
    validates_length_of :description, maximum: 200
    validates_length_of :imageUrl, maximum: 200
    validates_length_of :name, maximum: 80
    validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
    validates_uniqueness_of :name

end
