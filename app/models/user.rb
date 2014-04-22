class User < ActiveRecord::Base
	# Listing 6.6 Validating the presence of a name attribute. 	
	#validates :name, presence: true
	#   same as
	#validates(:name, presence: true)

	#Listing 6.29. The complete implementation for secure passwords. 
	before_save { self.email = email.downcase }
	# This converts the email address to all lower case before saving

	#Listing 8.18. A before_create callback method to create remember_token. 
	# immediately before creating a new user in the database.
	before_create :create_remember_token
  # Calls create_remember_token method before creating the user

	#Listing 6.12. Adding a length validation for the name attribute. 
	validates :name,  presence: true, length: { maximum: 50 }

	#Listing 6.10. Validating the presence of the name and email attributes. 
	#validates :email, presence: true

	#       Goes with code in /spec/models/user_spec.rb
	#Listing 6.14. Validating the email format with a regular expression. 
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	#validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  	#Listing 6.32. A valid email regex that disallows double dots in email addresses. 
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  	#Listing 6.18. Validating the uniqueness of email addresses, ignoring case. 
  	#  **** This does not work ***
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }  

   	#Listing 6.26. Getting the initial password tests to pass. 
   	# Comment this out to get the tests to fail.
   	has_secure_password

   	#Listing 6.29. The complete implementation for secure passwords. 
   	validates :password, length: { minimum: 6 }

	# Listing 8.18. A before_create callback to create remember_token. 
	def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private
  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
