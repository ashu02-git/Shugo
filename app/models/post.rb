class Post < ApplicationRecord
  # User:PostとCategory:Post = 1:N
  belongs_to :user
  belongs_to :category
  attachment :image
end
