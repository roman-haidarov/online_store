class Item < ApplicationRecord
  has_many :order_item, dependent: :destroy
  has_many :orders, through: :order_item
  has_many :basket_item, dependent: :destroy
  has_many :baskets, through: :basket_item
end
