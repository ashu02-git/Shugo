class Category < ApplicationRecord
  # Category:Post = 1:N
  has_many :posts, dependent: :destroy
end
