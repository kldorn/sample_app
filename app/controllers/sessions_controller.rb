class SessionsController < ApplicationController
	#Listing 8.3. The initial Sessions controller. 
	def new
  end

  	#Listing 8.10. An (unsuccessful) attempt at handling failed signin. 
  def create
  	# the params has has all the information needed to authenticate the user
  	user = User.find_by(email: params[:session][:email].downcase)
		#pulls the user out of the db based on the submitted email address.

  	# params[:session][:email] is a hash for the submitted email
    if user && user.authenticate(params[:session][:password])
    	# params[:session][:password] is a hast for the submitted password

      #Listing 8.13. The completed Sessions controller create action (not yet working). 
      # Sign the user in and redirect to the user's show page. 
      sign_in user
      redirect_to user
    else
      #Listing 8.12. Correct code for failed signin. Using flash.now
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!      		
      # flash and error message
      render 'new'
      # render the /app/views/sessions/new.html.erb
    end
  end  	

  def destroy
    #Listing 8.29. Destroying a session (user signout). 
    sign_out
    redirect_to root_url
  end
end