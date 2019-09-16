class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }

  has_many :posts, dependent: :destroy

  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following


  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  # has_many :active_relationships, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :passive_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  # has_many :following, through: :active_relationships, source: :followed
  # has_many :followers, through: :passive_relationships, source: :follower

  # def follow(user)
  # 	active_relationships.create(followed_id: user.id)
  # end

  # def unfollow(user)
  # 	active_relationships.find_by(followed_id: user.id).destroy
  # end

  # def following?(user)
  # 	following.include?(user)
  # end
end
