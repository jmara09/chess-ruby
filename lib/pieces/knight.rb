require_relative 'piece'

class Knight < Piece
  def initialize(coord = nil, color = 'white')
    white_knight = "\u2658"
    black_knight = "\u265E"
    symbol = color == 'white' ? white_knight : black_knight
    super(coord, color, symbol)
  end

  def check_square(delta, current_position, board, color = 'white')
    result = super
    result[0] = nil if result.first == 'own piece'
    result
  end

  def deltas
    jump
  end
end
