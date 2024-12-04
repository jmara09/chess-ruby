require_relative 'piece'

class Knight < Piece
  def initialize(coord = nil, player = 1)
    white_knight = "\u2658"
    black_knight = "\u265E"
    symbol = player == 1 ? white_knight : black_knight
    super(coord, player, symbol)
  end

  def check_square(delta, current_position, board, player = 1)
    result = super
    result[0] = nil if result.first == 'own piece'
    result
  end

  def deltas
    { around: [
      [-2, -1],
      [-2, 1],
      [2, -1],
      [2, 1],
      [-1, -2],
      [1, -2],
      [-1, 2],
      [1, 2]
    ] }
  end
end
