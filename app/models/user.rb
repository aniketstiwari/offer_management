class User < ApplicationRecord
  has_many :user_departments
  has_many :deparments, through: :user_departments
end
