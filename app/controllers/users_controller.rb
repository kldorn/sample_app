class UsersController < ApplicationController
  
  #Listing 7.5. The Users controller with a show action. 
  #Corresponds to \app\views\layouts\user\show.html.erb file
  def show
    @user = User.find(params[:id])
    #Find method retrieves user from db 
  end

  #Corresponds to \app\views\layouts\user\new.html.erb file
  def new
  	#Listing 7.18. Adding an @user variable to the new action. 
  	@user = User.new
  end
  
  #Listing 7.21. A create action that can handle signup failure (but not success). 
  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)       #Listing 7.22.
    #returns initialization hash in place of [:user]

    if @user.save      # Handle a successful save.
      # Listing 7.28. Adding a flash message to user signup. 
      flash[:success] = "Welcome to the Sample App!"
      # Listing 7.26. User create action with save and redirect. 
      redirect_to @user
    else
      render 'new'
    end
  end

  #Listing 7.22. Using strong parameters in the create action. 
  private

  def user_params
    # Determines which parms are required versus allowed.
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

end
