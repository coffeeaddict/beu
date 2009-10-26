class HomeController < ApplicationController
  

  def index
    @beu = get_beus
  end

  def list
    @beu = get_beus
    render :partial => "list"
  end

  private
  def get_beus

    # when there is a current user then show the users following,
    # unless the user follows no one
    #
    if @current_user && @current_user.following_by_type('User').length > 0
      # dup to disassociate the arrray
      beus = @current_user.beus.dup

      @current_user.following_by_type('User').each do |user|
	user.beus.each do |beu|
	  beus << beu unless beus.include?(beu)
	end
      end

    else
      beus = Beu.find(:all, :limit => 50)

    end
    
    beus.sort! { |a,b| a.created_at.to_f <=> b.created_at.to_f }

    return beus.reverse
  end
end
