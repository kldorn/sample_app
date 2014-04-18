#Listing 7.8. A factory to simulate User model objects. 
#spec/factories.rb 

#Passing :user to the factory command tells FactoryGirl that
#the user definition is for a User model object.
FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
