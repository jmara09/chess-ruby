require_relative 'piece'

class Rook < Piece
  def initialize(coord = nil, player = 1)
    white_rook = "\u2656"
    black_rook = "\u265C"
    symbol = player == 1 ? white_rook : black_rook
    super(coord, player, symbol)
  end

  def deltas
    vertical.merge(horizontal)
  end
end
