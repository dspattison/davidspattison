class CreateC4Games < ActiveRecord::Migration
  def change
    create_table :c4_games, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin' do |t|
      t.string :player_a_email
      t.string :player_b_email
      t.integer :board

      t.timestamps
    end
  end
end
