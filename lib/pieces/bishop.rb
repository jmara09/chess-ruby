require_relative 'piece'

class Bishop < Piece
  def initialize(coord = nil, color = 'white')
    white_bishop = "\u2657"
    black_bishop = "\u265D"
    symbol = color == 'white' ? white_bishop : black_bishop
    super(coord, color, symbol)
  end

  def deltas
    diagonal
  end
end
