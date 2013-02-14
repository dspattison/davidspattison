class CreateFacebookUsers < ActiveRecord::Migration
  def self.up
    create_table :facebook_users do |t|
      t.integer :app_id, :null=>false
      t.integer :facebook_id, :null=>false
      t.string :auth, :null=>false
      t.string :email, :null=>false
      t.string :name
      
      t.integer :status, :null=>false
      
      #t.add_index :facebook_id
      
      t.timestamps
    end
    
    add_index :facebook_users, [:facebook_id, :app_id], :unique=>true
    add_index :facebook_users, :email
  end
  
  def self.down
    drop_table :facebook_users
  end
end

