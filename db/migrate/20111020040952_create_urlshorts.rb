class CreateUrlshorts < ActiveRecord::Migration
  def self.up
    create_table :urlshorts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin' do |t|
      t.string :target_url
      t.string :code

      t.timestamps
    end
    add_index :urlshorts, :code, :unique=>true
  end

  def self.down
    drop_table :urlshorts
  end
end
