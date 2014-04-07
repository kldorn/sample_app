#Listing 6.19. The migration for enforcing email uniqueness. 
class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  		add_index :users, :email, unique: true
  end
end
