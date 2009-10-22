class User < ActiveRecord::Base
  has_many :beus

  acts_as_follower
  acts_as_followable
end
