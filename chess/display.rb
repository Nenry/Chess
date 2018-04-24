require 'colorize'
require_relative 'cursor'


class Display

  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)

  end

  def render
    system "clear"
    cursor_pos = @cursor.cursor_pos
    8.times do |i|
      temp_row = ""
      8.times do |j|
        if [i, j] == cursor_pos
          temp_row << " ▵"
          next
        elsif @board[[i, j]].class == Piece
           temp_row << " P"
        else
          temp_row << " ▢"
        end

      end
      p temp_row
    end
    # @board.board.each do |row|
    #   temp_row = ""
    #   row.each do |piece|
    #     if piece.class == Piece
    #        temp_row << " P"
    #     else
    #       temp_row << " ▢"
    #     end
    #
    #   end
    #   p temp_row
    # end


  end



end
