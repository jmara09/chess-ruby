require_relative 'piece'

class Queen < Piece
  def initialize(coord = nil, player = 1)
    white_queen = "\u2655"
    black_queen = "\u265B"
    symbol = player == 1 ? white_queen : black_queen
    super(coord, player, symbol)
  end

  def deltas
    vertical.merge(horizontal).merge(diagonal)
  end
end
