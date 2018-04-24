require 'colorize'
require 'cursor.rb'


class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    
  end
  
  
  
   
end 


