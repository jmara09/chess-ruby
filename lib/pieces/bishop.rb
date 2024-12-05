require_relative 'piece'

class Bishop < Piece
  def initialize(coord = nil, player = 1)
    white_bishop = "\u2657"
    black_bishop = "\u265D"
    symbol = player == 1 ? white_bishop : black_bishop
    super(coord, player, symbol)
  end

  def deltas
    diagonal
  end
end
