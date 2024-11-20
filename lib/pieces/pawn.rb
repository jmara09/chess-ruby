require_relative 'piece'

class Pawn < Piece
  def initialize(notation = nil, player = 1)
    white_pawn = "\u2659"
    black_pawn = "\u265F"
    symbol = player == 1 ? white_pawn : black_pawn
    super(notation, player, symbol)
  end

  def check_diagonal(board, player)
    coord = convert_notation
    deltas_diagonal = [[-1, -1], [-1, +1]]
    deltas = []

    deltas_diagonal.each do |delta|
      diagonal_coord = [
        delta[0] + coord[0],
        delta[1] + coord[1]
      ]

      next unless diagonal_coord[0].between?(0, board.size - 1) &&
                  diagonal_coord[1].between?(0, board[0].size - 1)

      piece = board[diagonal_coord[0]][diagonal_coord[1]][:piece]

      next if piece.nil? || piece.player == player

      deltas << delta
    end

    deltas
  end

  def deltas(board, player = @player)
    squares = []
    deltas = check_diagonal(board, player)
    unless deltas.empty?
      deltas.each do |delta|
        squares << delta
      end
    end
    squares << [-1, 0]
    squares << [-2, 0] if moved == false
    squares
  end

  def available_squares(offsets = deltas)
    super
  end
end
