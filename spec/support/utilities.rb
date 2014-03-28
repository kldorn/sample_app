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



