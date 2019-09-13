class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :image, presence: true

  # has_attached_file :image, styles: { :medium => "640x" }
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :of_followed_users, -> (following_users) { where user_id: following_users }

  def self.visible_to_users user
  	user.of_followed_users(user.following) << user
  end

end
