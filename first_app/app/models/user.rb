class User < ActiveRecord::Base
  #attr accessible :email, :name
  has_many :microposts
  has_many :comments
  validate :user, presence: true, length: { minimum: 8 }
end
