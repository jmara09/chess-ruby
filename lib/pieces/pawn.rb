require_relative 'piece'

class Pawn < Piece
  attr_accessor :moved

  def initialize(coord = nil, color = 'white')
    white_pawn = "\u2659"
    black_pawn = "\u265F"
    symbol = color == 'white' ? white_pawn : black_pawn
    super(coord, color, symbol)
    @moved = false
  end

  def deltas
    steps = moved ? 1 : 2
    black_restrictions = %i[up upper_left upper_right]
    white_restrictions = %i[down lower_left lower_right]
    deltas = vertical(steps).merge(diagonal(1))
    deltas = deltas.except(*white_restrictions) if color == 'white'
    deltas = deltas.except(*black_restrictions) if color == 'black'
    deltas
  end

  def available_squares(board)
    squares = super
    diagonal_deltas = color == 'white' ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
    diagonal_coord = diagonal_deltas.inject([]) { |arr, delta| arr << [coord[0] + delta[0], coord[1] + delta[1]] }

    squares.reject do |square_coord|
      square = board[square_coord[0]][square_coord[1]]
      square == '' && diagonal_coord.include?(square_coord)
    end
  end
end
