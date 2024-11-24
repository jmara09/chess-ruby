require_relative 'piece'

class Bishop
  def initialize(notation = nil, player = 1)
    white_bishop = "\u2657"
    black_bishop = "\u265D"
    symbol = player == 1 ? white_bishop : black_bishop
    super(notation, player, symbol)
  end

  def deltas
    deltas = { upper_left: [], upper_right: [], lower_left: [], lower_right: [] }
    (1..7).each do |index|
      deltas[:upper_left] << [-index, -index]
      deltas[:upper_right] << [-index, index]
      deltas[:lower_left] <<  [index, -index]
      deltas[:lower_right] << [index, index]
    end
    deltas
  end
end
