class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ゲスト登録情報
  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.name = "Guest"
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
    end
  end
  # 画像attachment
  attachment :profile_image
  # User:Post = 1:N
  has_many :posts, dependent: :destroy
  # User:Favorite = 1:N
  has_many :favorites, dependent: :destroy
  # User:PostComment = 1:N
  has_many :post_comments, dependent: :destroy
  # フォロー用中間テーブル( User:User= N:N )
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_relationships, source: :user
  ## フォロー機能メソッド
  # 他人ならフォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  # フォローを外す(フォローしていたら)
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  # フォローしているか
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
