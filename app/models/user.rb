class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :validatable

  has_one :basket, dependent: :destroy
  has_many :tokens, dependent: :destroy
  has_many :orders, dependent: :destroy
end
