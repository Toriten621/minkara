class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, dependent: :destroy
  has_one_attached :image
end
