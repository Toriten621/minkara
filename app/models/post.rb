class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_one_attached :image
  def self.search(query)
    if query.present?
      joins(:user).where(
        "posts.title LIKE :q OR posts.body LIKE :q OR users.email LIKE :q",
        q: "%#{query}%"
      )
    else
      all
    end
  end
end
