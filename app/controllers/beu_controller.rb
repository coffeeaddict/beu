class BeuController < ApplicationController

  before_filter :has_valid_login?

  def create
    beu = Beu.new(params[:beu])
    beu.user = @current_user

    if ( beu.save )

      render (:update) { |page|
	page.insert_html(:bottom, 'beu_lijstje', '<li class="beu">' + t(:beu, :who => @current_user.name, :what => beu.content) + "</li>")
      }
    else
      render :text => "Ja, wat?!"
    end
  end

end
