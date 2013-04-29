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
  
  NAMES = {
    EMPTY => "",
    A => "A",
    B => "B",
  }
  NAMES_HTML = {
    EMPTY => "&nbsp;",
    A => "A",
    B => "B",
  }
  
  
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
  
  def turn_number
    turns = 0
    
    @columns.each do |col|
      col.each do |cell|
        turns += 1 if cell != EMPTY
      end
    end
    
    turns
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
      
      (filled_rows-1).downto(0) do |i|
        column_value = column_value << 1 #move up one bit
        #must not do above action on last iteration
        
        column_value |= (c[i] == B) ? 1 : 0# 1 if B
      end
      
      # puts "c: #{c.inspect}, filled_rows: #{filled_rows}, column_value: #{column_value}, b: #{@board}"
      
      @board <<= 3
      @board |= (filled_rows & 7)
      @board <<= 6
      @board |= (column_value & 63)
    end
    @board <<= 1#need to pad for empty at end
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
    #vertical
    (0..6).each do |start_col|
      (0..2).each do |start_row|
        # puts [@columns[start_col][start_row], @columns[start_col][start_row+1], @columns[start_col][start_row+2], @columns[start_col][start_row+3]].inspect,  set_has_winner?([@columns[start_col][start_row], @columns[start_col][start_row+1], @columns[start_col][start_row+2], @columns[start_col][start_row+3]]) if start_col==1 and start_row==0 
        if set_has_winner? [@columns[start_col][start_row], @columns[start_col][start_row+1], @columns[start_col][start_row+2], @columns[start_col][start_row+3]]
          @winner = @columns[start_col][start_row]
          return 
        end
      end
    end
    
    
    #horizontal
    (0..3).each do |start_col|
      (0..5).each do |start_row|
        test_cells = [@columns[start_col][start_row], @columns[start_col+1][start_row], @columns[start_col+2][start_row], @columns[start_col+3][start_row]]
        # puts set_has_winner?(test_cells), test_cells.inspect if start_col == 2 and start_row==0
        if set_has_winner? test_cells
          # puts "found horinzotal winner at [#{start_col}-#{start_col+4}, #{start_row}]"
          @winner = @columns[start_col][start_row] 
          return
        end
      end
    end
    
    # /
    (0..3).each do |start_col|
      (0..2).each do |start_row|
        test_cells = [@columns[start_col][start_row], @columns[start_col+1][start_row+1], @columns[start_col+2][start_row+2], @columns[start_col+3][start_row+3]]
        # puts set_has_winner?(test_cells), test_cells.inspect if start_col == 2 and start_row==0
        if set_has_winner? test_cells
          # puts "found / winner at [#{start_col}, #{start_row}]"
          @winner = @columns[start_col][start_row] 
          return
        end
      end
    end
    
    # \
    (0..3).each do |start_col|
      (3..5).each do |start_row|
        test_cells = [@columns[start_col][start_row], @columns[start_col+1][start_row-1], @columns[start_col+2][start_row-2], @columns[start_col+3][start_row-3]]
        # puts set_has_winner?(test_cells), test_cells.inspect if start_col == 2 and start_row==0
        if set_has_winner? test_cells
          # puts "found \ winner at [#{start_col}, #{start_row}]"
          @winner = @columns[start_col][start_row] 
          return
        end
      end
    end
    
    
  end
  
  def set_has_winner? row
    return false if row.empty?
    return false if row[0] == EMPTY
    
    row.each do |i|
      return false if row[0] != i #stop if one element does not match
    end
    return true
    
  end
end
