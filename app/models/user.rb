class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy # User:Post = 1:N
  has_many :favorites, dependent: :destroy # User:Favorite = 1:N
  has_many :post_comments, dependent: :destroy # User:PostComment = 1:N

  attachment :profile_image # プロフィール画像attachment

  # ゲスト情報登録
  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.name = "Guest"
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
    end
  end

  # 退会済みか確認
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # 部分一致ユーザ検索
  def self.search(word)
    @user = User.where("name LIKE?", "%#{word}%")
  end
end
