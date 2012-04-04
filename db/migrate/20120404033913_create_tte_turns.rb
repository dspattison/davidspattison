class CreateTteTurns < ActiveRecord::Migration
  def change
    create_table :tte_turns do |t|
      t.integer :game_id
      t.integer :number
      t.integer :board

      t.timestamps
    end
  end
end
