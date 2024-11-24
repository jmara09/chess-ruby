require_relative 'piece'

class Rook
  def initialize(notation = nil, player = 1)
    white_rook = "\u2656"
    black_rook = "\u265C"
    symbol = player == 1 ? white_rook : black_rook
    super(notation, player, symbol)
  end

  def deltas
  end
end
