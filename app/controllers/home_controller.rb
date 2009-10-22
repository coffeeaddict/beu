class HomeController < ApplicationController
  def index
    @current_user = User.find(1)
    @beu = Beu.find(:all)
  end

end
