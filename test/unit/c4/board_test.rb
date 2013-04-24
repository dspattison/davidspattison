require 'test_helper'

class C4::BoardTest < ActiveSupport::TestCase
  
  test "static methods on empty board" do
    b = C4::Board.new 0
    #puts b.columns.inspect
    #bad moves
    assert !b.legal_move?(-1), -1
    assert !b.legal_move?(7)
    assert !b.legal_move?(1.1)
    assert !b.legal_move?('adgas')
    
    (0..6).each do |i|
      assert b.legal_move?(i)
    end
    
    assert C4::Board::A, b.next_player
  end
  
  test "compute columns 1" do
    b = C4::Board.new 2305843009213693952 #move in far left column
    #puts b.columns.inspect
    assert_equal C4::Board::A, b.columns[0][0], b.columns.inspect 
  end
  test "compute columns 2" do
    b = C4::Board.new 2305843009213693952+4573968371548160 #move in far left column
    #puts b.columns.inspect
    assert_equal C4::Board::A, b.columns[0][0], b.columns.inspect
    assert_equal C4::Board::B, b.columns[1][0], b.columns.inspect 
    
    #test serializing
    assert_equal b.board, C4::Board.new(b.board).board
  end
  
  test "compute columns 3" do
    # A in col 0
    # B in col 1
    # A in col 6
    b = C4::Board.new 2305843009213693952+4573968371548160 +192
    # puts b.columns.inspect
    assert_equal C4::Board::A, b.columns[0][0], b.columns.inspect
    assert_equal C4::Board::B, b.columns[1][0], b.columns.inspect
    assert_equal C4::Board::A, b.columns[6][0], b.columns.inspect
    
    #test serializing
    assert_equal b.board, C4::Board.new(b.board).board
  end
  
  test "compute columns 4" do
    # A in col 0
    # B in col 1
    # A in col 6
    # B in col 1
    b = C4::Board.new 2305843009213693952 + 31454828647415808 + 192 
    # puts b.columns.inspect
    assert_equal C4::Board::A, b.columns[0][0], b.columns.inspect
    assert_equal C4::Board::B, b.columns[1][0], b.columns.inspect
    assert_equal C4::Board::B, b.columns[1][1], b.columns.inspect
    assert_equal C4::Board::A, b.columns[6][0], b.columns.inspect
    
    #test serializing
    b2 = C4::Board.new b.board #re-serialize
    # puts b2.columns.inspect
    assert_equal b.board, b2.board, "Serialized board does not match"
    assert_equal b.columns, b2.columns, "@columns do not match"
  end
  
  test "compute simple vertical winner" do
    b = C4::Board.new 18014398509481984
    # puts b.columns.inspect
    assert b.has_winner?, "No winner"
    assert_equal C4::Board::A, b.winner, "Wrong winner"
  end
  
  test "compute simple horizontal winner" do
    b = C4::Board.new 17902028783616 
    # puts b.board
    # puts b.columns.inspect
    assert b.has_winner?, "No winner"
    assert_equal C4::Board::A, b.winner, "Wrong winner"
  end
  
  
  
  test "moves" do
    b = C4::Board.new 0 #move in far left column
    # puts b.columns.inspect
    # puts b.board
    
    [1,2,1,2,1,2].each_with_index do |column_id, i|
      b.move!(column_id)
      assert column_id, b.columns[column_id][i/2]
      b2 = C4::Board.new b.board #re-serialize
      # puts "Move in column #{column_id} at turn #{i}", b.columns.inspect, b2.columns.inspect
      
      assert_equal b.board, b2.board, "Serialized board does not match"
      assert_equal b.columns, b2.columns, "@columns do not match"
      assert !b.has_winner?, "Should not have a winner yet"
      
      assert C4::Board::A, b.columns[1][0]
      assert [C4::Board::B, C4::Board::EMPTY].include? b.columns[2][0] 
    end
    # puts "final"
    b.move! 1
    assert b.has_winner?
    assert_equal C4::Board::A, b.winner
    
  end
  
  test "move in same column" do
    b = C4::Board.new 0
    (0..5).each do |i|
      
      
      b.move! 3
      
      
      
      assert C4::Board::A, b.columns[3][0]
    end
    
  end
  
  test "horizontal winner 2" do
    b = C4::Board.new 0
    assert_moves_with_no_winner b, [4,4,3,4,2,4,2]
    
    assert_move_with_winner b, 4, C4::Board::B
    
  end
  
  test "/ winner" do
    b = C4::Board.new 0
    assert_moves_with_no_winner b, [0,1,1,2,2,3,2,3,3,5]
    
    # puts b.board, b.columns.inspect
    assert_move_with_winner b, 3, C4::Board::A
  end
  
  test "\ winner" do
    b = C4::Board.new 0
    assert_moves_with_no_winner b, [3,2,2,1,1,0,1,0,0,6]
    
    # puts b.board, b.columns.inspect
    assert_move_with_winner b, 0, C4::Board::A
  end
  
  #helper function to move the game along
  def assert_moves_with_no_winner b, moves
    moves.each_with_index do |column_id, i|
      assert !b.has_winner?
      turns_before = b.turn_number
      
      b.move! column_id
      
      assert !b.has_winner?, "There should not be a winner after move #{i}"
      assert_equal turns_before+1, b.turn_number, "Turn number did not increment"
    end
  end
  
  def assert_move_with_winner b, column_id, winner
    assert !b.has_winner?, "Board already has a winner"
    
    b.move! column_id
    
    assert b.has_winner?, "Board did not have a winner after move"
    assert_equal winner, b.winner, "Wrong winner"
  end
  
end
 
