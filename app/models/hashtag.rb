class Hashtag < ApplicationRecord
  validates :hash_name, presence: true, length: { maximum: 30 }
  has_many :post_hashtag_relations
  has_many :posts, through: :post_hashtag_relations
end
