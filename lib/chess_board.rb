class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { { symbol: ' ', notation: nil, piece: nil } } }
  end

  def notations
    row_length = @board.size

    @board.each do |row|
      col = 'a'

      row.each do |square|
        square[:notation] = col + row_length.to_s
        col.next!
      end

      row_length -= 1
    end
  end
end
