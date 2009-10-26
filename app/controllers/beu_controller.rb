class BeuController < ApplicationController

  before_filter :has_valid_login?, :except => [ "search" ]

  def create
    beu = Beu.new(params[:beu])
    beu.user = @current_user

    if ( beu.save )

      render (:update) { |page|
	page.insert_html(:top, 'beu_lijstje', '<li class="beu">' + t(:beu, :who => @current_user.name, :what => beu.content) + "</li>")
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
		     
end
