# $ rails generate migration add_remember_token_to_users

class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	# Listing 8.16. A migration to add a remember_token to the users table. 
  	add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end
end
