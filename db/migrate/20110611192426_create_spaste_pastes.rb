class CreateSpastePastes < ActiveRecord::Migration
  def self.up
    create_table :spaste_pastes do |t|
      t.text :body
      t.string :title
      t.string :public_key
      t.string :version
      t.integer :status

      t.timestamps
    end
    add_index :spaste_pastes, :public_key
  end

  def self.down
    drop_table :spaste_pastes
  end
end
