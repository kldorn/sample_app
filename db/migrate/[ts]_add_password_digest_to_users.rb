#Listing 6.23. The migration to add a password_digest column to the users table. 
#db/migrate/[ts]_add_password_digest_to_users.rb 
class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
  end
end
