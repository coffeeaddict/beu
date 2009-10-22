class Beu < ActiveRecord::Base
  belongs_to :user

  # when a user follows a beu, it is a favorite of the user
  acts_as_followable
end
