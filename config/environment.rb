# Be sure to restart your server when you modify this file
# ok

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

PW_SALT = "1df33ece81d44867cd2e7499097554b2c0d813064b00b569f75f46bd7ca38b75fccf673df0437acd132fcf89a61b23a340b6bc7a9146257ea860de19209c3bf9"

# my keys
ENV['RECAPTCHA_PUBLIC_KEY']  = '6Leb4QgAAAAAAHAjPAKH6Ghzmsbx3RiY0iF5oBJq'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Leb4QgAAAAAAMvxOD0JOSZLMAntGlOWf4dCtuBr'

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.i18n.default_locale = :ru
  config.cache_store = :mem_cache_store, { :namespace => 'storeapp' }
  config.gem 'datanoise-actionwebservice', :lib => 'actionwebservice'
  if RAILS_ENV == 'production'
	config.log_level = :warn
  end
end
