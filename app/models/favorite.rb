class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # post_idとuser_idの組み合わせは１つまで（各ユーザは１投稿1いいね）
  validates_uniqueness_of :post_id, scope: :user_id
end
