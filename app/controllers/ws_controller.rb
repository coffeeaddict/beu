class WsController < ApplicationController
  wsdl_service_name 'WS'

  include Exceptions

  def login(username, password)
    if ( username && password )
      user = User.find( :first,
		        :conditions =>
		        [ "username = ? AND password = ?",
		 	  username,
			  User.make_hashed_password(password)
		        ]
                      );
      if ( user ) 
	session[:ws_user] = user.id
	return true
      else
	return false
      end
    end
  end

  def add(content)
    user = User.find( session[:ws_user] ) if session[:ws_user]

    if user
      if ( Beu.create( :user => user, :content => content ) )
	return { :user => user, :content => content }
      else
	raise Exception, "Beu not created"
      end
    else
      raise Exception, "Not logged in"
    end
  end

  def list
  end
end
