class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :validatable

  has_one :basket, dependent: :destroy
  has_many :items, dependent: :destroy
end
