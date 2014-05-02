class PublicController < ApplicationController
skip_before_filter :check_sign_in
  def index
  	render :layout => false
  end
  
  def menu
  	render :layout => false
  end
end
