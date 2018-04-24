require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos

    @board = board
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key) #calculating new pos


    if MOVES.include?(key)
      update_pos(MOVES[key])
      return nil
    elsif key == :return || key == :space
      return @cursor_pos
    elsif key == :ctrl_c # exit the terminal
      exit
    end






    #   if MOVES.include?(key)
    #     @cursor_pos[0] += MOVES[key][0]
    #     @cursor_pos[1] += MOVES[key][1]
    #   elsif key == :return || key == :space
    #     if @start_pos.empty?
    #       @start_pos = @cursor_pos
    #     else
    #       @board.move_piece(@start_pos, @cursor_pos)
    #       @start_pos = []
    #     end
    #   end
    #   case key
    #   when :left
    #
    #   when :right
    #
    #   when :up
    #   when :down
    #   end
    #   possible_pos +=
    # # end

  end

  def update_pos(diff)
    temp_cursor = @cursor_pos.dup
    temp_cursor[0] += diff[0]
    temp_cursor[1] += diff[1]
     @board.valid_pos?(temp_cursor)
    if @board.valid_pos?(temp_cursor)
      @cursor_pos = temp_cursor
    end
  end
end
