require_relative 'piece'

class Queen < Piece
  def initialize(notation = nil, player = 1)
    white_queen = "\u2655"
    black_queen = "\u265B"
    symbol = player == 1 ? white_queen : black_queen
    super(notation, player, symbol)
  end
end
