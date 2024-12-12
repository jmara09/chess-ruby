require_relative 'piece'

class King < Piece
  def initialize(coord = nil, color = 'white')
    white_king = "\u2654"
    black_king = "\u265A"
    symbol = color == 'white' ? white_king : black_king
    super(coord, color, symbol)
  end

  def deltas
    vertical(1).merge(horizontal(1)).merge(diagonal(1))
  end

  def check?(enemy_pieces, board)
    return false if enemy_pieces.empty?

    enemy_pieces.any? do |piece|
      piece.available_squares(piece.deltas, board).include?(coord)
    end
  end

  def check_mate(enemy_pieces, board)
    return false if enemy_pieces.empty?

    all_movements = enemy_pieces.flat_map { |piece| piece.available_squares(piece.deltas, board) }
    king_moves = available_squares(deltas, board)

    return check?(enemy_pieces, board) if king_moves.empty?

    king_moves.all? { |square| all_movements.include?(square) }
  end
end
