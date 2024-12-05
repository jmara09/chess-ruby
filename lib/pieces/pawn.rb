require_relative 'piece'

class Pawn < Piece
  attr_accessor :moved

  def initialize(coord = nil, player = 1)
    white_pawn = "\u2659"
    black_pawn = "\u265F"
    symbol = player == 1 ? white_pawn : black_pawn
    super(coord, player, symbol)
    @moved = false
  end

  def check_square(delta, current_position, board, player = 1)
    result = super
    diagonal_deltas = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

    result = [nil, nil] if diagonal_deltas.include?(delta) && result.first == 'empty'

    result
  end

  def deltas
    steps = moved ? 1 : 2
    black_restrictions = %i[up upper_left upper_right]
    white_restrictions = %i[down lower_left lower_right]
    deltas = vertical(steps).merge(diagonal(1))
    deltas = deltas.except(*white_restrictions) if player == 1
    deltas = deltas.except(*black_restrictions) if player == 2
    deltas
  end
end
