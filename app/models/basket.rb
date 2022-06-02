class Basket < ApplicationRecord
  belongs_to :user
  has_many :basket_item, dependent: :destroy
  has_many :items, through: :basket_item
end
