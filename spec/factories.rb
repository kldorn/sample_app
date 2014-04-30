#Listing 7.8. A factory to simulate User model objects. 
#spec/factories.rb 

#Passing :user to the factory command tells FactoryGirl that
#the user definition is for a User model object.
#FactoryGirl.define do
#  factory :user do
#    name     "Michael Hartl"
#    email    "michael@example.com"
#    password "foobar"
#    password_confirmation "foobar"
#  end
#end

#Listing 9.31: Defining a Factory Girl sequence.
# Instead of hardcoding, we can arrange 
# for a sequence of names and email addresses 
# using the sequence method:
 FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    #Listing 9.41: Adding a factory for administrative users.
    #To write tests in spec/requests/user_pages_spec.rb for the delete functionality, 
    #it’s helpful to be able to have a factory to create admins. 
    #We can accomplish this by adding an :admin block to our factories
 	  factory :admin do
      admin true
    end
  end
end # FactoryGirl.define do

# Here sequence takes a symbol corresponding 
# to the desired attribute (such as :name) 
# and a block with one variable, 
# which we have called n. 
# Upon successive invocations of the FactoryGirl method,
# FactoryGirl.create(:user)
# The block variable n is automatically incremented, 
# so that the first user has name “Person 1” 
# and email address “person_1@example.com”, 
# the second user has name “Person 2” 
# and email address “person_2@example.com”, and so on. 