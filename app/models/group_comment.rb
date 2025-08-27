class GroupComment < ApplicationRecord
  belongs_to :group_topic
  belongs_to :user

  validates :content, presence: true
end
