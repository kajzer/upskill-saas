class ProfilesController < ApplicationController
  before_action :only_curent_user, only: :new
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  private
  
  def only_curent_user
    unless (user_signed_in? && params[:user_id].to_i == current_user.id)
      #flash[:notice] = "#{current_user.id} and evalute to: #{params[:user_id].to_i == current_user.id.to_i}"
      flash[:notice] = "You are trying to enter restricted area for you"
      redirect_to root_url
    end
  end
end