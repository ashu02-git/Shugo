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
  # User:Post = 1:N
  has_many :posts, dependent: :destroy
  # User:Favorite = 1:N
  has_many :favorites, dependent: :destroy
end
