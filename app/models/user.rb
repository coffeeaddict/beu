require 'digest.rb'

class User < ActiveRecord::Base
  has_many :beus

  acts_as_follower
  acts_as_followable

  # extra, non-db, attributes for passwords
  attr_accessor :password_confirm, :new_password

  # validations
  validates_presence_of :username, :password, :name, :email
  validates_length_of :password, :minimum => 6
  validates_uniqueness_of :username

  validate { |user|
    user.errors.add_to_base("Usernames can only contain 'word characters'") if user.username =~ /\W+/
    user.errors.add_to_base("Usernames may not contain spaces") if user.username =~ /\s+/
  }

  # password protection
  before_create :hash_password
  before_update :hash_new_password

  def self.make_hashed_password(password)
    return Digest::SHA512.hexdigest(password + PW_SALT)
  end

  # make sure the user leaves no trace
  before_destroy { |record|
    # destroy all the users blog entries
    Beu.destroy_all "user_id = #{record.id}"

    # stop the following
    record.all_following.each { |that|
      record.stop_following(that)
    }
  }
    
  private
    def hash_password
      return if self.password.nil? or !self.password
      if self.password == self.password_confirm
	self.password = User.make_hashed_password( self.password )

      else
	logger.error("Mismatched password")
	self.errors.add("password", "Passwords dont match");

      end
    end

    def hash_new_password
      logger = RAILS_DEFAULT_LOGGER;

      if self.new_password
        if ( self.new_password == self.password_confirm )
          self.password = User.make_hashed_password( self.new_password )

        else
          logger.error("Mismatched password")
          self.errors.add("password", "Newly supplied passwords mismatch")

        end
      end
    end  

end
