class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :active_relationships, class_name: "Relationship",
         foreign_key: "follower_id",
         dependent: :destroy
has_many :followings, through: :active_relationships, source: :followed
has_many :passive_relationships, class_name: "Relationship",
          foreign_key: "followed_id",
          dependent: :destroy
has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image
  before_validation :set_default_name, on: :create
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :group_posts, dependent: :destroy
  has_many :group_topics, dependent: :destroy
  has_many :group_comments, dependent: :destroy
  def follow(user)
    followings << user unless self == user
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    followings.include?(user)
  end
  private

  def set_default_name
    self.name = "名無し" if self.name.blank?
  end
end
