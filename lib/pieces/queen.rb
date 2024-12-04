require_relative 'piece'

class Queen < Piece
  def initialize(coord = nil, player = 1)
    white_queen = "\u2655"
    black_queen = "\u265B"
    symbol = player == 1 ? white_queen : black_queen
    super(coord, player, symbol)
  end

  def deltas
    deltas = { upper_left: [], upper_right: [], lower_left: [], lower_right: [] }
    (1..7).each do |index|
      deltas[:upper_left] << [-index, -index]
      deltas[:upper_right] << [-index, index]
      deltas[:lower_left] <<  [index, -index]
      deltas[:lower_right] << [index, index]
    end
    deltas[:forward] = (-7..-1).to_a.product([0]).reverse
    deltas[:backward] = (1..7).to_a.product([0])
    deltas[:left] = [0].product((-7..-1).to_a).reverse
    deltas[:right] = [0].product((1..7).to_a)
    deltas
  end
end
