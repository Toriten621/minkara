class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_posts, dependent: :destroy
  has_many :group_topics, dependent: :destroy

  belongs_to :owner, class_name: "User"
end
