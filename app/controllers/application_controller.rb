class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Listing 8.14. Including the Sessions helper module 
  # ~app\helpers\sessions_helper.rb
  #into the Application controller. 
  # Helpers are included in the views but not the controllers.
  include SessionsHelper
end
