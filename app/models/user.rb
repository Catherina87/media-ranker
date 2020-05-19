class User < ApplicationRecord
  
  has_many :votes
  has_many :works, :through => :votes 

  validates :username, presence: true, length: { in: 3..25 }
end
