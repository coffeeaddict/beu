class BeuController < ApplicationController
  def create
    beu = Beu.new(params[:beu])
    beu.user = @current_user
    beu.save

    render (:update) { |page|
      page.insert_html(:bottom, 'beu_lijstje', '<li class="beu">' + t(:beu, :who => @current_user.name, :what => beu.content) + "</li>")
    }
  end

end
