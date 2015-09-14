class Micropost < ActiveRecord::Base
  #attr_accessible :content, :user_id
  belongs_to :user
  has_many :likes
  has_many :comments
  validates :content, presence: true, :length => { :maximum => 140 }
  validates :user_id, presence: true

  def likescount
    self.likes.count
  end
end
