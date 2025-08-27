class GroupTopic < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :group_comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
