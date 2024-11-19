class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { { symbol: ' ', notation: nil, piece: nil } } }
  end
end
