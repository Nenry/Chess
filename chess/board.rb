require_relative 'display'
require_relative 'cursor'
require_relative 'pieces'
require "colorize"
class Board
    attr_reader :board
  def initialize
    @board = Array.new(8) {Array.new(8)}
     initialize_board
  end


  def initialize_board
    @board.flatten.each_index do |i|
      if i.between?(0, 15) || i.between?(48, 63)
        @board[i] = Piece.new
      else
        @board[i] = NullPiece.new
      end
    end
    @board = @board.each_slice(8).to_a
  end

  def move_piece(start_pos, end_pos)
    s_row,s_col = start_pos
    e_row,e_col = end_pos
    if @board[s_row][s_col].class == NullPiece
      raise "No piece there!"
    elsif @board[e_row][e_col] == nil
      raise "That is off the board!"
    else
      @board[e_row][e_col] = @board[s_row][s_col]
      @board[s_row][s_col] = NullPiece.new
    end
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def valid_pos?(pos)
    pos.first.between?(0,7) && pos.last.between?(0,7)
  end


end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  # cur = Cursor.new([0,0], board)
  disp = Display.new(board)
  loop do
  disp.render
  disp.cursor.get_input
  end
end
