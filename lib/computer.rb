require_relative 'chess_board'

class Computer
  attr_reader :active_pieces, :captured, :color, :king

  def initialize(color, king, pieces)
    @color = color
    @king = king
    @active_pieces = pieces
    @captured = []
  end

  def random_piece(board)
    shuffled_pieces = @active_pieces.shuffle
    piece = shuffled_pieces.find do |p|
      !p.available_squares(p.deltas, board).empty?
    end
    return nil unless piece

    piece
  end

  def random_move(board)
    piece = random_piece(board)
    return puts 'No available piece' if piece.nil?

    legal_moves = piece.available_squares(piece.deltas, board)
    raise "No legal moves available for piece: #{piece.inspect}" if legal_moves.empty?

    random_coord = legal_moves.sample
    random_square = board[random_coord[0]][random_coord[1]]

    unless random_square == ''
      @captured << random_square.symbol
      random_square.coord = nil
    end

    piece.moved = true if piece.is_a?(Pawn)
    board[random_coord[0]][random_coord[1]] = piece
    board[piece.coord[0]][piece.coord[1]] = ''
    piece.coord = random_coord
  end
end
