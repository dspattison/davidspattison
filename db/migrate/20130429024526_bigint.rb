class Bigint < ActiveRecord::Migration
  def up
    # change_column :c4_games      , :id, :bigint           
    change_column :c4_games      , :board, :bigint       
    # change_column :facebook_users, :id, :bigint
    # change_column  :facebook_users, :app_id, :bigint  
    # change_column :facebook_users, :facebook_id, :bigint
    # change_column :facebook_users, :status, :bigint
    # change_column :spaste_pastes , :id, :bigint
    # change_column :spaste_pastes , :status, :bigint 
    # change_column :tte_games     , :id, :bigint
    # change_column :tte_turns     , :id, :bigint 
    # change_column :tte_turns     , :game_id, :bigint 
    # change_column :tte_turns     , :number, :bigint
    change_column :tte_turns     , :board, :bigint
    # change_column :urlshorts     , :id, :bigint
  end

  def down
  end
end
