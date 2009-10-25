# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # all controllers should have a current user
  attr_accessor :current_user

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  layout 'default.html.erb'
  before_filter :get_current_user, :set_locale

  def set_locale
    if params[:locale]
      session[:locale] = params[:locale]
    end

    if session[:locale]
      I18n.locale = session[:locale]

    elsif ( current_user && current_user.locale != "" )
      I18n.locale = current_user.locale

    else
      I18n.locale = I18n.default_locale
    end
  end

  def get_current_user
    if !session[:user].nil?
      @current_user = User.find(session[:user])
    end
  end
 
  def has_valid_login?
    if session[:user].nil?
      return redirect_to :controller => "user", :action => "login"
    end

    # refresh the item on the session
    @current_user = User.find(session[:user]) unless @current_user

    # set a cookie - it is reasonably save as everything needs to be in order
    cookies[:login] = {
      :value   => Digest::MD5.hexdigest(
        PW_SALT+'|'+
        request.remote_ip+'|'+
        current_user.username+'|'+
        current_user.password
      ),
      :expires => 1.week.from_now
    }

    return true    
  end
end
