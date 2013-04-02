class C4::Board
  # a 7x6 board
  # move are only allowed from the top to the bottom 
  # most avaliable slot
  # @board is an integer representation, fancy
  # @columns is a 2-dim array with cells below (starting at zero!)
  
  # @board store 9 bits per row
  # 0-2: number of cells that are filled
  # 3-8: bit representing the value in the row, 0=A, 1=B 
  # 7 columns, 7*9=63 bits total
  
  
  EMPTY = 0
  A = 1
  B = 2
  
  VALID_CELLS = [EMPTY, A, B]
  
  
  def initialize(board)
    @board = board
    compute_columns @board
    compute_winner 
  end
  
  def legal_move?(column_id)
    return false if !valid_column?(column_id)
    #true iff top entry is empty
    return @columns[column_id][5] == EMPTY
  end
  
  def valid_column?(column_id)
    return [0, 1, 2, 3, 4 ,5, 6].include? column_id
  end
  
  def move!(column_id)
    raise Exception.new("Invalid move, #{column_id.inspect}") unless legal_move?(column_id)
    
    @columns[column_id].each_with_index do |r, i|
      if r == EMPTY
        @columns[column_id][i] = next_player
        break
      end
    end
    compute_board #fix the int
    compute_winner
  end
  
  
  def next_player
    #we will figure this out by counting the number of A vs B tiles
    a_tiles = b_tiles = 0
    @columns.each do |c|
      c.each do |r|
        a_tiles +=1 if r == A
        b_tiles +=1 if r == B
      end
    end
    
    # puts "a_tiles #{a_tiles} b_tiles #{b_tiles}"
    return A if a_tiles == b_tiles
    return B
  end
  
  def has_winner?
    return @winner != nil
  end
  
  def game_over?
    
  end
  
  def winner
    @winner
  end
  
  def columns
    @columns
  end
  
  def board
    @board
  end
  
  private
  
  #broken
  def compute_board
    @board = 0
    @columns.each do |c|
      filled_rows=0
      c.each do |r|
        filled_rows += (r == EMPTY ? 0 : 1)
      end
      
      column_value = 0
      
      filled_rows.times do |i|
        column_value += (c[i] == B) ? 1 : 0# 1 if B
        column_value = column_value << 1 #move up one bit
      end
      
      # puts "c: #{c.inspect}, filled_rows: #{filled_rows}, column_value: #{column_value}, b: #{@board}"
      
      @board += (filled_rows & 9)
      @board <<= 3
      @board += (column_value & 63)
      @board <<= 6
    end
    @board
  end
    
  
  
  
  def compute_columns(columns)
    @columns = []
    (0..6).each do |c|
      
      row = [EMPTY] * 6
      #top 3 bits, integer
      filled_rows = (columns >> 61) & 7
      #puts "column bits: #{(columns >> 55) & 63}"
      
      filled_rows.times do |i|
        #top bits, 3-9, sequential; add one to offset A vs B
        #puts "filled_rows: #{filled_rows}; #{i}: #{(columns >> 55-i) & 1} #{((columns >> 55-i) & 1) + 1}"
        row[i] = ((columns >> 55+i) & 1) + 1
      end
      @columns << row
      columns = columns << 9 #iterate!
    end
  end
  
  def compute_winner
    @winner = nil
    #for now, just compute a complete column
    @columns.each do |c|
      if c[0] != EMPTY and c[0] == c[1] and c[0] == c[2] and c[0] == c[3]
        # puts "winner: #{c[0]}"
        @winner = c[0]
        return
      end
    end
  end
end
