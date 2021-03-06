class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :image, presence: true

  # has_attached_file :image, styles: { :medium => "640x" }
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
end
