require_relative 'piece'

class Pawn < Piece
  attr_accessor :moved

  def initialize(notation = nil, player = 1)
    white_pawn = "\u2659"
    black_pawn = "\u265F"
    symbol = player == 1 ? white_pawn : black_pawn
    super(notation, player, symbol)
    @moved = false
  end

  def check_square(delta, current_position, board, player = 1)
    result = super
    diagonal_deltas = [[-1, -1], [-1, 1]]

    result = [nil, nil] if diagonal_deltas.include?(delta) && result.first == 'empty'

    result
  end

  def deltas
    deltas = { forward: [[-1, 0]], upper_left: [[-1, -1]], upper_right: [[-1, 1]] }
    deltas[:forward] << [-2, 0] if moved == false
    deltas
  end
end
