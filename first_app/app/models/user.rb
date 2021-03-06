class User < ActiveRecord::Base
  has_many :microposts
  has_many :comments
  has_many :likes
  validates :name, presence: true, length: { minimum: 6, maximum: 8 }
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
