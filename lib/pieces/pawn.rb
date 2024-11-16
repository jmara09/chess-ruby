require_relative 'piece'

class Pawn < Piece
  def initialize(notation = nil, player = 1)
    white_pawn = "\u2659"
    black_pawn = "\u265F"
    symbol = player == 1 ? white_pawn : black_pawn
    super(notation, player, symbol)
  end

  def deltas
    squares = []
    squares << [-1, 0]
    squares << [-2, 0] if moved == false
    squares
  end

  def available_squares
  end
end
