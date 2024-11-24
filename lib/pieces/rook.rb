require_relative 'piece'

class Rook < Piece
  def initialize(notation = nil, player = 1)
    white_rook = "\u2656"
    black_rook = "\u265C"
    symbol = player == 1 ? white_rook : black_rook
    super(notation, player, symbol)
  end

  def deltas
    deltas = { forward: nil, backward: nil, left: nil, right: nil }
    deltas[:forward] = (-7..-1).to_a.product([0]).reverse
    deltas[:backward] = (1..7).to_a.product([0])
    deltas[:left] = [0].product((-7..-1).to_a).reverse
    deltas[:right] = [0].product((1..7).to_a)
    deltas
  end
end
