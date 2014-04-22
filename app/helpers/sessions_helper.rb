# Ruby provides a module facility for packaging functions together 
# and including them in multiple places
# These helpers are automatically included in Rails view.
# Use the Sessions helper functions (include SessionsHelper) in controllers 
# to include the module into the Application controller (Listing 8.14).
module SessionsHelper

	#Listing 8.19. The complete (but not-yet-working) sign_in function. 
	def sign_in(user)
    	remember_token = User.new_remember_token
    	cookies.permanent[:remember_token] = remember_token
    	user.update_attribute(:remember_token, User.digest(remember_token))
    	self.current_user = user
  end

  #Listing 8.23. The signed_in? helper method. 
  # Used for <% if signed_in? %> 
  def signed_in?
    !current_user.nil?
  end

  # Listing 8.20. Defining assignment to current_user.
  # The purpose of current_user, accessible in both controllers and views, 
  # is to allow constructions such as
  # <%= current_user.name %>
  # and    redirect_to current_user
  def current_user=(user)
    @current_user = user
  end
  # The line self.current_user = user in module SessionsHelper
  # is an assignment which has special syntax for defining an
  # assignment function. self.current_user = user
  # is converted to current_user=(...) thereby invoking the current_user= method.

  # Listing 8.22. Finding the current user using the remember_token. 
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    #set the @current_user instance variable to the user corresponding to the remember token, 
    #but only if @current_user is undefined.
  end

  # Listing 8.30. The sign_out method in the Sessions helper module.
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    # we first change the user’s remember token in the database (in case the cookie has been stolen, 
    # as it could still be used to authorize a user
    cookies.delete(:remember_token)
    # remove the remember token from the session
    self.current_user = nil
  end


end
