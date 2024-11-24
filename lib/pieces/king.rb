require_relative 'piece'

class King < Piece
  def initialize(notation = nil, player = 1)
    white_king = "\u2654"
    black_king = "\u265A"
    symbol = player == 1 ? white_king : black_king
    super(notation, player, symbol)
  end
end
