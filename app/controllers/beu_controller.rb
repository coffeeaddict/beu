class BeuController < ApplicationController

  before_filter :has_valid_login?, :except => [ "search", "index" ]

  def index
    begin
      @beu = Beu.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @beu = nil
    end
  end

  def create
    beu = Beu.new(params[:beu])
    beu.user = @current_user

    if ( beu.save )

      render (:update) { |page|
	page.insert_html(:top, 'beu_lijstje',
			 '<li class="beu">' + t(:beu,
						:who => link_to(@current_user.username, :controller => "user", :action => "beus"),
						:what => format_beu(beu.content)) + "</li>")
      }
    else
      render :text => "Ja, wat?!"
    end
  end

  def search
    @beu = Beu.find( :all,
                     :conditions => [ "content like ?", "%"+params[:id]+"%" ],
		     :limit      => 50
		   )
  end

  def destroy
    beu = Beu.find(params[:id])
    if beu.user == @current_user
      beu.destroy
      render :text => "Gone. Forever."
    else
      render :text => "I really dont think so"
    end
  end

  def fave
    beu = Beu.find(params[:id])
    @current_user.follow(beu)

    render(:update) { |page|
      page.insert_html(:bottom, 'beu_' + params[:id],
		       '<small><br />In russia favourites have you</small>')
    }
  end

end
