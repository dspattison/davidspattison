class Tte::Board
  
  TILE_EMPTY  = 0
  TILE_X      = 1
  TILE_O      = 2
  
  def initialize(board)
    @board = board
    @winner = nil
    if has_winner?
      @winner = compute_winner
    end
    @squares = compute_squares @board
  end
  
  def legal_move?(square_id)
    return false if has_winner? 
    square(square_id) == TILE_EMPTY
  end
  
  def valid_tile?(tile)
    [TILE_EMPTY, TILE_X, TILE_O].include? tile
  end
  
  def move!(square_id, tile)
    raise Exception.new("Invalid Move") unless legal_move? square_id
    raise Exception.new("Invalid Tile") unless valid_tile? tile
    
    
    board_bits = 0
    
    board_bits = tile << (square_id * 2)
    @board |= board_bits
    
    @squares = compute_squares @board
    @winner = compute_winner
    
  end
  
  def has_winner?
    !@winner.nil?
  end
  
  def winner
    @winner
  end
  
  
  def square(square_id)
    squares[square_id]
  end
  
  def squares
    @squares
  end
  
  def nested_squares
    [@squares[0..2], @squares[3..5], @squares[6..8]]
  end
  
  def board
    @board
  end
  
  
  private
  
  def compute_winner
    
    #do across
    if array_same_non_zero_value([@squares[0], @squares[1], @squares[2]])
      return @squares[2]
    end
    
    if array_same_non_zero_value([@squares[3], @squares[4], @squares[5]])
      return @squares[3]
    end
    
    if array_same_non_zero_value([@squares[6], @squares[7], @squares[8]])
      return @squares[6]
    end
    
  end
  
  def array_same_non_zero_value values
    running_value = values.first
    return false if running_value == 0
    values.each do |v|
      return false if running_value != v
    end
    true
  end
  
  def compute_squares board
    squares = Array.new(9)
    
   9.times.each do |i|
     squares[i] = (board & (3 << (i<<1))) >> (i << 1)
     puts board
   end
   puts squares.inspect
   squares
  end
  
end