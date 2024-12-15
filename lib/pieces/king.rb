require_relative 'piece'

class King < Piece
  def initialize(coord = nil, color = 'white')
    white_king = "\u2654"
    black_king = "\u265A"
    symbol = color == 'white' ? white_king : black_king
    super(coord, color, symbol)
  end

  def deltas
    vertical(1).merge(horizontal(1)).merge(diagonal(1))
  end
end
