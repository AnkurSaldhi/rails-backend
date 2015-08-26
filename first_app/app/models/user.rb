class User < ActiveRecord::Base
  #attr accessible :email, :name
  has_many :microposts
end
