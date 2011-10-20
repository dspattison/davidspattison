class CreateUrlshorts < ActiveRecord::Migration
  def self.up
    create_table :urlshorts do |t|
      t.string :target_url
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :urlshorts
  end
end
