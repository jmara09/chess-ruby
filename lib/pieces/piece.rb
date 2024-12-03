require_relative '../position_converter'

class Piece
  include PositionConverter

  attr_reader :symbol
  attr_accessor :notation, :moved, :player

  def initialize(notation = nil, player = 1, symbol = nil)
    @player = player
    @notation = notation
    @symbol = symbol
  end

  def to_coord(notation = @notation)
    super
  end

  def deltas
    raise NotImplementedError, 'Subclasses must define the method'
  end

  def check_square(delta, current_position, board, player = 1)
    result = [nil, nil]
    square = [
      delta[0] + current_position[0],
      delta[1] + current_position[1]
    ]

    return result unless square[0].between?(0, 7) &&
                         square[1].between?(0, 7)

    piece = board[square[0]][square[1]][:piece]

    if piece.nil?
      result = ['empty', square]
    elsif piece.player != player
      result = ['enemy piece', square]
    elsif piece.player == player
      result[0] = 'own piece'
    end

    result
  end

  def available_squares(delta_group, board)
    current_position = to_coord(notation)
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
