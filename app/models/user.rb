class User < ApplicationRecord
  devise :database_authenticatable, 
         :registerable,
         :validatable

  has_one :basket, dependent: :destroy
end
