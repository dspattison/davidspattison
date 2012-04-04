require 'test_helper'

class Tte::BoardTest < ActiveSupport::TestCase
  
  
  test "x moves" do
    b = Tte::Board.new 0
    b.move! 0, Tte::Board::TILE_X
    b.move! 1, Tte::Board::TILE_X
    b.move! 2, Tte::Board::TILE_X
    
    assert b.has_winner?
    assert b.winner == Tte::Board::TILE_X
    
  end
  
  test "both moves" do
    b = Tte::Board.new 0
    b.move! 0, Tte::Board::TILE_X
    b.move! 3, Tte::Board::TILE_O
    b.move! 1, Tte::Board::TILE_X
    b.move! 4, Tte::Board::TILE_O
    b.move! 2, Tte::Board::TILE_X
    begin
      b.move! 5, Tte::Board::TILE_O #already lost
      assert false, 'should not allow move once there is a winner'
    rescue Exception=>ex
      assert true
    end
    
    
    
    assert b.has_winner?
    assert b.winner == Tte::Board::TILE_X
    
  end
  
end

