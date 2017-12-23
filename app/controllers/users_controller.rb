class UsersController < ApplicationController
  before_action :authenticate_user!
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
    #@profile = Profile.find_by user_id: @user.id unnecesery because you can chanin @user.profile
  end
  
end