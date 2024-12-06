require_relative 'piece'

class Rook < Piece
  def initialize(coord = nil, color = 'white')
    white_rook = "\u2656"
    black_rook = "\u265C"
    symbol = color == 'white' ? white_rook : black_rook
    super(coord, color, symbol)
  end

  def deltas
    vertical.merge(horizontal)
  end
end
