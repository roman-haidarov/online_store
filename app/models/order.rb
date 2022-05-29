class Order < ApplicationRecord
  has_many :order_item, dependent: :destroy
  has_many :items, through: :order_item
end
