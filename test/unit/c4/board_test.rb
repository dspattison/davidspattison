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
      assert !b.legal_move?(i)
    end
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
  end
  
  # test "moves" do
    # b = C4::Board.new 576460752303423488 #move in far left column
    # puts b.columns.inspect
    # puts b.board
#     
    # b.move! 1
    # puts b.columns.inspect
    # puts b.board
#     
  # end
  
end
 
