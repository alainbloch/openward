class ReviseRoles < ActiveRecord::Migration
  def self.up    

    add_column :roles_users, :created_at, :datetime
    add_column :roles_users, :updated_at, :datetime

    
    add_column :roles, :authorizable_type,  :string, :limit => 30
    add_column :roles, :authorizable_id,    :integer
    add_column :roles, :created_at,         :datetime
    add_column :roles, :updated_at,         :datetime
    
  end

  def self.down
    remove_column :roles_users, :created_at 
    remove_column :roles_users, :updated_at 
    
    remove_column :roles, :authorizable_type 
    remove_column :roles, :authorizable_id 
    remove_column :roles, :created_at 
    remove_column :roles, :updated_at 
  end
end
