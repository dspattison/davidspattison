class Tte::Board
  
  TILE_EMPTY  = 0
  TILE_X      = 1
  TILE_O      = 2
  
  @@winning_combos = [
    #left right
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    #up down
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    #across
    [0, 4, 8],
    [6, 4, 2],
  ]
  
  
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
    raise Exception.new("Has Winner") unless !has_winner?
    raise Exception.new("Invalid Move") unless legal_move? square_id
    raise Exception.new("Invalid Tile") unless valid_tile? tile
    raise Exception.new("Out of order player") unless tile == next_player
    
    board_bits = 0
    
    board_bits = tile << (square_id * 2)
    @board |= board_bits
    
    @squares = compute_squares @board
    @winner = compute_winner
    
  end
  
  #gives the player who will do the next move
  def next_player
    count_x = @squares.count{|x| x == TILE_X}
    count_o = @squares.count{|x| x == TILE_O}
    if count_x == count_o
      return TILE_X
    end
    return TILE_O
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
    
    @@winning_combos.each do |set| 
      if array_same_non_zero_value([@squares[set[0]], @squares[set[1]], @squares[set[2]]])
        return @squares[set[0]]
      end
    end
    # #do across
   nil
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
   end
   squares
  end
  
end