class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image
  validates :body, presence: true, unless: -> { image.attached? }
end
