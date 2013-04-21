class CreateTteTurns < ActiveRecord::Migration
  def change
    create_table :tte_turns, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin' do |t|
      t.integer :game_id
      t.integer :number
      t.integer :board

      t.timestamps
    end
  end
end
