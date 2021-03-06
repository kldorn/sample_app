# Listing 9.29: A Rake task for populating the database
# with sample users.
# /lib/tasks/sample_data.rake

# This defines a task db:populate 
# that creates an example user with name and email address 
# replicating our previous one, and then makes 99 more.

# With the :db namespace as in Listing 9.29, 
# we can invoke the Rake task as follows:

# bundle exec rake db:reset
# bundle exec rake db:populate
# bundle exec rake test:prepare

namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    # ensures that the Rake task has access to the local 
    # Rails environment, including the User model 
    # (and hence User.create!)

    #Listing 9.40: The sample data populator code with an admin user.
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
    # Make the first user an admin.
    #User.create!(name: "Example User",
    #             email: "example@railstutorial.org",
    #            password: "foobar",
    #            password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

end