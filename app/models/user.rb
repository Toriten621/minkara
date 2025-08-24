class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image
  before_validation :set_default_name, on: :create

  private

  def set_default_name
    self.name = "名無し" if self.name.blank?
  end
end
