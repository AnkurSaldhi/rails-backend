class Micropost < ActiveRecord::Base
  #attr_accessible :content, :user_id
  belongs_to :user
  has_many :comments
  validates :content, :length => { :maximum => 140 }
end
