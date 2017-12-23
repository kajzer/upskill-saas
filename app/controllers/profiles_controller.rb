class ProfilesController < ApplicationController
  before_action :only_curent_user, only: :new
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find(params[:user_id])
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(current_user.id) #He is using params[:user_id]
    else
      render action: :new
    end
  end
  
  #GET to /users/:user_id/profile/edit
  def edit
    @profile = Profile.find_by_user_id(current_user.id)
  end
  
  # PATCH to /users/:user_id/profile/edit
  def update
    @profile = Profile.find_by_user_id(current_user.id)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_path(current_user.id)
    else
      render action: :edit
    end
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
  
  def only_curent_user
    unless (user_signed_in? && params[:user_id].to_i == current_user.id)
      #flash[:notice] = "#{current_user.id} and evalute to: #{params[:user_id].to_i == current_user.id.to_i}"
      flash[:notice] = "You are trying to enter restricted area for you"
      redirect_to root_url
    end
  end
end