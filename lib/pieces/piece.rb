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

  def check_square(delta, current_position, board, color = 'white')
    result = [nil, nil]
    square = [
      delta[0] + current_position[0],
      delta[1] + current_position[1]
    ]

    return result unless square[0].between?(0, 7) &&
                         square[1].between?(0, 7)

    piece = board[square[0]][square[1]]

    if piece == ''
      result = ['empty', square]
    elsif piece.color != color
      result = ['enemy piece', square]
    elsif piece.color == color
      result[0] = 'own piece'
    end

    result
  end

  def available_squares(delta_group, board)
    current_position = coord
    squares = []
    delta_group.each_value do |deltas|
      deltas.each do |delta|
        result = check_square(delta, current_position, board)
        next if result.first.nil?
        break if result.first == 'own piece'

        squares << result.last
        break if result.first == 'enemy piece'
      end
    end
    squares
  end
end
