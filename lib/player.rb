require_relative 'chess_board'
require_relative 'convertable'

class Player
  include Convertable

  attr_reader :player, :captured

  def initialize(player = 1)
    @player = player
    @captured = []
  end

  def valid_move?(start_square, end_square, board)
    piece = start_square[:piece]
    deltas = piece.deltas
    moves = piece.available_squares(deltas, board)
    moves.include?(end_square)
  end

  def move(start_pos, end_pos, chess_board)
    start_coord = to_coord(start_pos)
    end_coord = to_coord(end_pos)

    return puts 'Invalid notation' if start_coord == false || end_coord == false

    start_square = chess_board.board[start_coord[0]][start_coord[1]]
    end_square = chess_board.board[end_coord[0]][end_coord[1]]

    return puts 'Invalid. Square is empty' if start_square[:piece].nil?

    return puts 'Invalid move' unless valid_move?(start_square, end_coord, chess_board.board)

    return puts 'Invalid input. Please choose you own piece' unless start_square[:piece].player == player

    @captured << end_square[:symbol] unless end_square[:piece].nil?

    end_square[:piece] = start_square[:piece]
    end_square[:piece].notation = end_square[:notation]
    end_square[:symbol] = end_square[:piece].symbol
    start_square[:piece] = nil
    start_square[:symbol] = ''

    end_square[:piece].moved = true if end_square[:piece].is_a?(Pawn)
    chess_board.print_board
  end
end
