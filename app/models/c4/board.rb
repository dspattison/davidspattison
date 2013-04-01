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
    @winner = compute_winner 
  end
  
  def legal_move?(column_id)
    return false if !valid_column?(column_id)
    #true iff top entry is empty
    return @columns[column_id][5] == EMPTY
  end
  
  def valid_column?(column_id)
    return [0..6].include? column_id
  end
  
  def move!(column_id)
    #raise Exception.new("Invalid move") if !legal_move?(column_id)
    
    @columns[column_id].each_with_index do |r, i|
      if r == EMPTY
        @columns[column_id][i] == next_player
      end
    end
    compute_board #fix the int
  end
  
  
  def next_player
    B # todo
  end
  
  def has_winner?
    
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
  
  def compute_board
    @board = 0
    @columns.each do |c|
      filled_rows=0
      c.each do |r|
        filled_rows += r == EMPTY ? 1 : 0
      end
      
      column_value = 0
      
      filled_rows.times do |i|
        column_value += c[i] == B ? 1 : 0# 1 if B
        column_value = column_value << 1 #move up one bit
      end
      
      @board << 3
      @board += filled_rows
      @board << 6
      @board += column_value
    end
    @board
  end
    
  
  
  
  def compute_columns(columns)
    @columns = []
    (0..6).each do |c|
      
      row = [EMPTY] * 6
      filled_rows = (columns >> 61) & 7
      
      filled_rows.times do |i|
        row[i] = ((columns >> 55-i) & 1) + 1
      end
      @columns << row
      columns = columns << 9 #iterate!
    end
  end
  
  def compute_winner
    
  end
end