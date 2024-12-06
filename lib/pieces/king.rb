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

  def check?(enemy_moves)
    enemy_moves.include?(coord)
  end

  def check_mate(enemy_moves)
    king_movement = available_squares
    king_movement.all? { |square| enemy_moves.include?(square) }
  end
end
