class User < ActiveRecord::Base
	# Listing 6.6 Validating the presence of a name attribute. 	
	#validates :name, presence: true
	#   same as
	#validates(:name, presence: true)

	#Listing 6.29. The complete implementation for secure passwords. 
	before_save { self.email = email.downcase }

	#Listing 6.12. Adding a length validation for the name attribute. 
	validates :name,  presence: true, length: { maximum: 50 }

	#Listing 6.10. Validating the presence of the name and email attributes. 
	#validates :email, presence: true

	#  **** This does not work ***
	#       Goes with code in /spec/models/user_spec.rb
	#Listing 6.14. Validating the email format with a regular expression. 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	#validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }


  	#Listing 6.18. Validating the uniqueness of email addresses, ignoring case. 
  	#  **** This does not work ***
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }  

   	#Listing 6.26. Getting the initial password tests to pass. 
   	# Comment this out to get the tests to fail.
   	has_secure_password

   	#Listing 6.29. The complete implementation for secure passwords. 
   	validates :password, length: { minimum: 6 }

end
