class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_one_attached :profile_image
  validates :name, presence: true
end
