#\app\controllers\users_controller.rb

class UsersController < ApplicationController
  
  # Listing 9.12: Adding a signed_in_user before filter.
  # Require users to be signed in.
  # before filter users before_action
  # before filters apply to every action in a controller,
  # we restrict the filter to act only on the :edit and :update actions 
 

  #Listing 9.21: Requiring a signed-in user for the index action.
  #before_action :signed_in_user, only: [:edit, :update]
  before_action :signed_in_user, only: [:index, :edit, :update]
  
  #Listing 9.14: A correct_user before filter to protect the edit/update pages.
  before_action :correct_user,   only: [:edit, :update]

  #Listing 9.46: A before filter restricting the destroy action to admins.
  before_action :admin_user,     only: :destroy

  #Listing 9.14: A correct_user before filter to protect the edit/update pages.
  def index
    # Listing 9.23: The user index action.
    #@users = User.all
    # User.all to pull all the users out of the database, 
    #assigning them to an @users instance variable 
    #for use in the view

    #Listing 9.34: Paginating the users in the index action.
    @users = User.paginate(page: params[:page])
  end

  #Listing 7.5. The Users controller with a show action. 
  #Corresponds to \app\views\layouts\user\show.html.erb file
  def show
    @user = User.find(params[:id])
    #Find method retrieves user from db 
  end

  # Listing 9.2: The user edit action.
  def edit
    # Listing 9.14: A correct_user before filter to protect the edit/update pages. 
    # Removed the following line 
    # @user = User.find(params[:id])
    # Now that the correct_user before filter defines @user, we can omit it here.
  end

  # Listing 9.8: The initial user update action.
  def update

    # Listing 9.14: A correct_user before filter to protect the edit/update pages. 
    # Removed the following line  
    # @user = User.find(params[:id])
    # Now that the correct_user before filter defines @user, we can omit it here.

    if @user.update_attributes(user_params)
      # Handle a successful update.
      # Listing 9.10: The user update action.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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
      # Listing 8.27. Signing in the user upon signup. 
      # sign_in method defined in listing 8.27
      sign_in @user
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

  # Listing 9.12: Adding a signed_in_user before filter.
  # Before filters
  def signed_in_user
    # Listing 9.18: Adding store_location to the signed-in user before filter.
    # redirect_to signin_url, notice: "Please sign in." unless signed_in?
    unless signed_in?
      store_location
      # store_location defined in app/helpers/sessions_helper.rb
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  # Listing 9.14: A correct_user before filter to protect the edit/update pages. 
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    # current_user method defined in app/helpers/sessions_helper.rb
  end

  #Listing 9.44: Adding a working destroy action.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  #Listing 9.46: A before filter restricting the destroy action to admins.
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end


end # class UsersController < ApplicationController
