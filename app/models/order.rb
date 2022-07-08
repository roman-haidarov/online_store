class Order < ApplicationRecord
  belongs_to :user
  has_many :order_item, dependent: :destroy
  has_many :items, through: :order_item
end
