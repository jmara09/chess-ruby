require_relative '../moveable'

class Piece
  include Moveable

  attr_reader :symbol
  attr_accessor :coord, :moved, :color

  def initialize(coord = nil, color = 'white', symbol = nil)
    @color = color
    @coord = coord
    @symbol = symbol
  end

  def deltas
    raise NotImplementedError, 'Subclasses must define the method'
  end

  def available_squares(board)
    squares = []
    deltas.each_value do |offsets|
      offsets.each do |delta|
        square = [
          delta[0] + coord[0],
          delta[1] + coord[1]
        ]

        next unless square[0].between?(0, 7) &&
                    square[1].between?(0, 7)

        piece = board[square[0]][square[1]]

        squares << square if piece == '' || piece.color != color

        next if piece == '' || is_a?(Knight)

        break
      end
    end
    squares
  end
end
