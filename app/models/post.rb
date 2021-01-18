class Post < ApplicationRecord
  # 画像attachment
  attachment :image
  # User:PostとCategory:Post = 1:N
  belongs_to :user
  belongs_to :category
  # postとhashtagの中間テーブル
  has_many :post_hashtag_relations
  has_many :hashtags, through: :post_hashtag_relations
  # Post:PostComment = 1:N
  has_many :post_comments, dependent: :destroy
  # Post:Favorite = 1:N
  has_many :favorites, dependent: :destroy

  # ユーザが投稿に対していいね済みか判別
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 部分一致投稿検索
  def self.search(word)
    @post = Post.where("title LIKE?", "%#{word}%")
  end
  # ハッシュタグ作成(DBにコミット直前)
  after_create do
    @post = Post.find_by(id: self.id)
    hashtags = self.body.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) # ハッシュタグを検出
    @post.hashtags = []
    hashtags.uniq.map do |hashtag|
      # 先頭の'#'外して保存
      tag = Hashtag.find_or_create_by(hash_name: hashtag.delete('#'))
      @post.hashtags << tag
    end
  end

  before_update do
    @post = Post.find_by(id: self.id)
    @post.hashtags.clear
    hashtags = self.body.scan(/[#][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) # ハッシュタグを検出
    hashtags.uniq.map do |hashtag|
      # 先頭の'#'外して保存
      tag = Hashtag.find_or_create_by(hash_name: hashtag.delete('#'))
      @post.hashtags << tag
    end
  end
end
