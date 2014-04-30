class AddAdminToUsers < ActiveRecord::Migration
  def change
  	#Listing 9.39: The migration to add a boolean admin attribute to users.
    #add_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
