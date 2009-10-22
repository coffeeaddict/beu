# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_beu_session',
  :secret      => '29cb4d4b5887bcac4a4a044c68169d5fa4f93ff0cea9f632e8abcc1041a843d3d112bfc3b88947c1aa389e77f171eb44cb60cba03310f9959afccc3cf94c42ff'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
