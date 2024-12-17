require_relative 'piece'

class Knight < Piece
  def initialize(coord = nil, color = 'white')
    white_knight = "\u2658"
    black_knight = "\u265E"
    symbol = color == 'white' ? white_knight : black_knight
    super(coord, color, symbol)
  end

  def deltas
    jump
  end
end
