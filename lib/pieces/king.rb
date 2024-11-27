require_relative 'piece'

class King < Piece
  def initialize(notation = nil, player = 1)
    white_king = "\u2654"
    black_king = "\u265A"
    symbol = player == 1 ? white_king : black_king
    super(notation, player, symbol)
    @check = false
  end

  def check?
    @check
  end

  def deltas
    deltas = {}
    deltas[:upper_left] = [[-1, -1]]
    deltas[:upper_right] = [[-1, 1]]
    deltas[:lower_left] = [[1, -1]]
    deltas[:lower_right] = [[1, 1]]
    deltas[:forward] = [[-1, 0]]
    deltas[:backward] = [[1, 0]]
    deltas[:left] = [[0, -1]]
    deltas[:right] = [[0, 1]]
    deltas
  end
end
