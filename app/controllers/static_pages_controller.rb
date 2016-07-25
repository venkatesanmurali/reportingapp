class StaticPagesController < ApplicationController
  
  def home
  	@report = current_user.reports.build if signed_in?
  end

  def help
  end

  def about
  end
  
  def contact
  end
end
