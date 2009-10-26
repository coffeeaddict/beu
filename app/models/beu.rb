class Beu < ActiveRecord::Base
  belongs_to :user

  # when a user follows a beu, it is a favorite of the user
  acts_as_followable

  validates_presence_of :content

  def self.last_cached
    Rails.cache.fetch('last_beus', :expires_in => 60.seconds) {
      find(:all, :limit => 50)
    }
  end

end
