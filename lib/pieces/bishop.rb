require_relative 'piece'

class Bishop
  def initialize(notation = nil, player = 1)
    white_bishop = "\u2657"
    black_bishop = "\u265D"
    symbol = player == 1 ? white_bishop : black_bishop
    super(notation, player, symbol)
  end
end
