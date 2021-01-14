class Post < ApplicationRecord
  # 画像attachment
  attachment :image
  # User:PostとCategory:Post = 1:N
  belongs_to :user
  belongs_to :category
  # postとhashtagの中間テーブル
  has_many :post_hashtag_relations
  has_many :hashtags, through: :post_hashtag_relations
  # Post:Favorite = 1:N
  has_many :favorites, dependent: :destroy
  # ユーザが投稿に対していいね済みか判別
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # DBにコミット直前に実施
  after_create do
    @post = Post.find_by(id: self.id)
    hashtags = self.body.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) # ハッシュタグを検出
    @post.hashtags = []
    hashtags.uniq.map do |hashtag|
      # 先頭の'#'外して保存
      tag = Hashtag.find_or_create_by(hash_name: hashtag.downcase.delete('#'))
      @post.hashtags << tag
    end
  end

  before_update do
    @post = Post.find_by(id: self.id)
    @post.hashtags.clear
    hashtags = self.body.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) # ハッシュタグを検出
    hashtags.uniq.map do |hashtag|
      # 先頭の'#'外して保存
      tag = Hashtag.find_or_create_by(hash_name: hashtag.downcase.delete('#'))
      @post.hashtags << tag
    end
  end
end
