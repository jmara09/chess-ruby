require 'colorize'
require_relative 'pieces_loader'

class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { { symbol: '', notation: nil, piece: nil } } }
  end

  def notations
    row_length = @board.size

    @board.each do |row|
      col = 'a'

      row.each do |square|
        square[:notation] = col + row_length.to_s
        col.next!
      end

      row_length -= 1
    end
  end

  def eight_pawns(player)
    row = player == 1 ? 6 : 1

    @board[row].each do |square|
      notation = square[:notation]
      square[:piece] = Pawn.new(notation, player)
      square[:symbol] = square[:piece].symbol
    end
  end

  def royalty(player)
    royals = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row = player == 1 ? 7 : 0

    @board[row].each_with_index do |square, index|
      notation = square[:notation]
      square[:piece] = royals[index].new(notation, player)
      square[:symbol] = square[:piece].symbol
    end
  end

  def set_pieces
    notations
    2.times do |index|
      eight_pawns(index + 1)
      royalty(index + 1)
    end
  end

  def print_board(moves = [])
    length = @board.length
    colors = %i[white black]

    @board.each_with_index do |row, row_index|
      line = []
      start_color = row_index.even? ? colors[0] : colors[1]
      current_color = start_color

      row.each_with_index do |square, col_index|
        line << if moves.include?([row_index, col_index])
                  "#{square[:symbol].center(6).colorize(background: :yellow)}"
                else
                  "#{square[:symbol].center(6).colorize(background: current_color)}"
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
