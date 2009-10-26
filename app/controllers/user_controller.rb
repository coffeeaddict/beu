class UserController < ApplicationController

  before_filter( :has_valid_login?,
                 :except => [ "login", "do_login", "signup", "beus", "create" ]
               )

  def login
    @user = User.new

    # when there is a cookie or token, try the login
    if ( ( cookies[:user] && !cookies[:user].empty? ) || params[:token] )
      return( redirect_to( :action => "do_login" ) )
    end
  end

  def do_login
    type = :unknown

    if !cookies[:user].nil? && cookies[:user] != ""
      @user = User.find( :first,
			 :conditions =>
			 [ "MD5(CONCAT(?,'|',?,'|',username,'|',password))=?",
			   PW_SALT, request.remote_ip, cookies[:user]
			 ]
                       );

      type = :cookie

    elsif params[:token]
      token = Token.find_by_token( params[:token] );
      @user = token.user if ( !token.nil? )
	
      type = :token

    elsif params[:user]
      @user = User.find( :first,
			 :conditions =>
			 [ "username = ? AND password = ?",
			   params[:user][:username],
			   User.make_hashed_password(params[:user][:password])
			 ]
                       )

      type = :form
    end

    if ( type == :form && !verify_recaptcha() )
      flash[:error] = "are you not human?"
      return( redirect_to :action => "login")
    end

    if !@user.nil?
      session[:user] = @user.id
      return( redirect_to :controller => "home", :action => "index" )

    else
      flash[:error] = "Login failed.<br/>"

      if type == :cookie
	flash[:error] += "Your login cookie was not valid"
	cookies[:user] = nil

      elsif type == :form
	flash[:error] += "Username and password do not match"

      elsif type == :token
	flash[:error] += "The token is invalid"

      else
	flash[:error] += "Something went terribly wrong."+
	  "We have been informed, please try again later"
	RAILS_DEFAULT_LOGGER.error("Unknown login type found");

      end

      return( redirect_to :action => "login" )
    end
  end

  def list
    @user = User.find(:all)
  end

  def beus
    id = params[:id]
    if id.to_i.to_s == id
      @user = User.find(params[:id])
    else
      @user = User.find( :first, :conditions => [ "username=?", id ] )
    end

    if @user
      @beu = @user.beus
    else
      render :text => "The user n'existe pas", :status => 404
    end
  end

  def favorites
    @beu = @current_user.following_by_type('Beu')
    @user = @current_user
    render :layout => "beus"
  end

  def logout
    session[:user] = nil
    cookies.delete(:user)

    redirect_to :controller => "home", :action => "index"
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if ( @user.save )
      @current_user = @user
      session[:user] = @user
      return( redirect_to :controller => "home", :action => "index" )
    end

    render :action => "signup"
  end

  def follow
    who = User.find(params[:id])
    @current_user.follow(who)
    render :text => "you are now following #{who.username}"
  end
  
end
