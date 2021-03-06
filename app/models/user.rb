class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader
  
  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  # 由於使用 restaurants 會和「使用者評論很多餐廳」重覆，將關聯名稱自訂為 :favorited_restaurants
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name  
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 「使用者喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 「使用者追蹤很多使用者」的多對多關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  
  # 「使用者被很多使用者追蹤」的多對多關聯
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 「使用者加入很多使用者為好友」的多對多關聯
  has_many :friendships, dependent: :destroy
  has_many :friendings, through: :friendships

  # 「使用者被很多使用者加為好友」的多對多關聯
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friending_id"
  has_many :friends, through: :inverse_friendships, source: :user

  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friending?(user)
    self.friendings.include?(user)
  end

  def all_friends(user)
    self.friendings(user)
    self.friends(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def inverse_friend?(user)
    self.inverse_friends.include?(user)
  end

end
