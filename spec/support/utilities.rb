#Eliminate the need for the full_title test helper 
#in Listing 5.29 by writing tests for the original helper method, 
#as shown in Listing 5.41. 
#(You will have to create both the spec/helpers directory 
#and the application_helper_spec.rb file.) 
#Then include it into the test using the code in Listing 5.42. 
#Verify by running the test suite that the new code is still valid. 
#Note: Listing 5.41 uses regular expressions, 
#which we’ll learn more about in Section 6.2.4. 
#(Thanks to Alex Chaffee for the suggestion 
#and code used in this exercise.)

#Listing 5.38. A more specific test for the Contact page. 
#spec/requests/static_pages_spec.rb 

require 'spec_helper'


# Listing 5.29 - 
# A file for RSpec utilities with a full_title function. 
# Replaces usage of Let function in
# C:\rails_projects\sample_app\spec\static_pages_spec.rb
def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
  else
    "#{base_title} | #{page_title}"
  end
end

# Listing 9.6: A test helper to sign users in.
def sign_in(user, options={})
# filling in the form doesn’t work when not using Capybara
  if options[:no_capybara]
    # Sign in when not using Capybara.
    # Override default signin method and manipulate the cookies directly
    # necessary when using one of the HTTP request methods directly (get, post, patch, or delete)
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

# Listing 8.34. Adding a helper method and a custom RSpec matcher. 
#include ApplicationHelper

#def valid_signin(user)
#  fill_in "Email",    with: user.email
 # fill_in "Password", with: user.password
#  click_button "Sign in"
#end

#Matches specific strings in .spec.rb files to a funtion
#RSpec::Matchers.define :have_error_message do |message|
#  match do |page|
#    expect(page).to have_selector('div.alert.alert-error', text: message)
#  end
#end

