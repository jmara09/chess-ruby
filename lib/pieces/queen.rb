require_relative 'piece'

class Queen < Piece
  def initialize(coord = nil, color = 'white')
    white_queen = "\u2655"
    black_queen = "\u265B"
    symbol = color == 'white' ? white_queen : black_queen
    super(coord, color, symbol)
  end

  def deltas
    vertical.merge(horizontal).merge(diagonal)
  end
end
