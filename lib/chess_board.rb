require 'colorize'
require_relative 'pieces_loader'

class ChessBoard
  attr_accessor :board, :white_pieces, :black_pieces, :white_king, :black_king

  def initialize
    @board = Array.new(8) { Array.new(8) { '' } }
    @white_pieces = []
    @black_pieces = []
  end

  def eight_pawns(color)
    row = color == 'white' ? 6 : 1

    @board[row].each.with_index do |_, index|
      coord = [row, index]
      @board[row][index] = Pawn.new(coord, color)
      if color == 'white'
        @white_pieces << @board[row][index]
      else
        @black_pieces << @board[row][index]
      end
    end
  end

  def royalty(color)
    royals = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row = color == 'white' ? 7 : 0

    @board[row].each_with_index do |_, index|
      coord = [row, index]
      @board[row][index] = royals[index].new(coord, color)
      if color == 'white'
        @white_king = @board[row][index] if @board[row][index].is_a?(King)
        @white_pieces << @board[row][index]
      else
        @black_king = @board[row][index] if @board[row][index].is_a?(King)
        @black_pieces << @board[row][index]
      end
    end
  end

  def set_pieces
    %w[white black].each do |color|
      eight_pawns(color)
      royalty(color)
    end
  end

  def print_board(moves = [], board_colors: %i[white black], highlight_color: :yellow)
    system 'clear'
    row_number = @board.length

    @board.each_with_index do |row, row_index|
      line = []
      start_color = row_index.even? ? board_colors[0] : board_colors[1]
      current_color = start_color

      row.each_with_index do |square, col_index|
        square_color = moves.include?([row_index, col_index]) ? highlight_color : current_color

        line << if square == ''
                  square.center(6).colorize(background: square_color)
                else
                  square.symbol.center(6).colorize(background: square_color)
                end

        current_color = current_color == board_colors[0] ? board_colors[1] : board_colors[0]
      end

      puts "#{row_number} #{line.join}"
      row_number -= 1
    end
    'abcdefgh'.chars.each { |chr| print "    #{chr} " }
    puts "\n\n"
    puts "'s' - save    'q' - exit\n".center(47)
  end
end
