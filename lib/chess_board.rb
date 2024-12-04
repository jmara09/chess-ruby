require 'colorize'
require_relative 'pieces_loader'

class ChessBoard
  attr_accessor :board, :white_pieces, :black_pieces

  def initialize
    @board = Array.new(8) { Array.new(8) { '' } }
    @white_pieces = []
    @black_pieces = []
  end

  def update_pieces
    @white_pieces = @white_pieces.reject { |piece| piece.coord == 'captured' }
    @black_pieces = @black_pieces.reject { |piece| piece.coord == 'captured' }
  end

  def eight_pawns(player)
    row = player == 1 ? 6 : 1

    @board[row].each.with_index do |_, index|
      coord = [row, index]
      @board[row][index] = Pawn.new(coord, player)
      if player == 1
        @white_pieces << @board[row][index]
      else
        @black_pieces << @board[row][index]
      end
    end
  end

  def royalty(player)
    royals = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row = player == 1 ? 7 : 0

    @board[row].each_with_index do |_, index|
      coord = [row, index]
      @board[row][index] = royals[index].new(coord, player)
      if player == 1
        @white_pieces << @board[row][index]
      else
        @black_pieces << @board[row][index]
      end
    end
  end

  def set_pieces
    2.times do |index|
      eight_pawns(index + 1)
      royalty(index + 1)
    end
  end

  def print_board
    length = @board.length
    colors = %i[white black]

    @board.each_with_index do |row, row_index|
      line = []
      start_color = row_index.even? ? colors[0] : colors[1]
      current_color = start_color

      row.each do |square|
        line << if square == ''
                  square.center(6).colorize(background: current_color)
                else
                  "#{square.symbol.center(6).colorize(background: current_color)}"
                end
        current_color = current_color == colors[0] ? colors[1] : colors[0]
      end

      puts "#{length} #{line.join}"
      length -= 1
    end
    'abcdefgh'.chars.each { |chr| print "    #{chr} " }
    puts
  end
end

# system 'clear'
# puts '      '.colorize(background: :magenta)
# p String.colors
#

chess = ChessBoard.new
chess.set_pieces
p chess.black_pieces
# knight = chess.board[7][1][:piece]
# deltas = knight.deltas
# squares = knight.available_squares(deltas, chess.board)
chess.print_board
