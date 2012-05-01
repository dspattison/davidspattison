require 'test_helper'

class Tte::BoardTest < ActiveSupport::TestCase
  
  test "both moves" do
    b = Tte::Board.new 0
    b.move! 0, Tte::Board::TILE_X
    b.move! 3, Tte::Board::TILE_O
    b.move! 1, Tte::Board::TILE_X
    b.move! 4, Tte::Board::TILE_O
    b.move! 2, Tte::Board::TILE_X
    assert_exception do
      b.move! 5, Tte::Board::TILE_O #already lost
    end
    
    
    
    assert b.has_winner?
    assert b.winner == Tte::Board::TILE_X
    
  end
  
  test "reject cheaters" do
    b = Tte::Board.new 0
    b.move! 0, Tte::Board::TILE_X
     
    assert_exception 'moving to already taken square' do
      b.move! 0, Tte::Board::TILE_O
    end
    
    assert_exception 'out of order turn' do
      b.move! 1, Tte::Board::TILE_X
    end
    
    assert_exception 'not a realy tile' do
      #
      b.move! 9, Tte::Board::TILE_X
    end
    
    assert_exception 'not a realy player' do
      b.move! 1, 3
    end
  end
  
  private 
  def assert_exception msg=''
    result = false
    begin
      yield
    rescue Exception=>ex
      result = true
    end
    assert result, msg
  end 
  
end

