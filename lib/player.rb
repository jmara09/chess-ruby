require_relative 'chess_board'
require_relative 'position_converter'

class Player
  include PositionConverter

  attr_reader :color, :captured, :name

  def initialize(color, king)
    @color = color
    @king = king
    @captured = []
  end

  def valid_piece?(coord, board)
    raise InvalidNotation, 'Invalid coordinate' unless coord

    square = board.board[coord[0]][coord[1]]
    raise InvalidPiece, 'Please select your own piece' if square == '' || square.color != color

    true
  end

  def select_piece(board)
    loop do
      print 'Please select a piece (e.g., "a1"): '
      input = gets.chomp
      coord = to_coord(input)

      begin
        valid_piece?(coord, board)
        piece = board.board[coord[0]][coord[1]]
        legal_moves = piece.available_squares(piece.deltas, board.board)

        if legal_moves.empty?
          puts "#{piece.class} at #{input} has no available moves."
          next
        end

        board.print_board(legal_moves)
        return piece
      rescue InvalidNotation => e
        puts "#{e.message} Please try again."
      rescue InvalidPiece => e
        puts e.message
      end
    end
  end

  def target_square(piece, notation, board)
    loop do
      coord = to_coord(notation)
      if coord.nil?
        puts 'Invalid notation. Please try again:'
      elsif piece.available_squares(piece.deltas, board.board).include?(coord)
        return coord
      else
        puts 'Illegal move. Please try again:'
      end
      notation = gets.chomp
    end
  end

  def move(end_notation, board)
    selected_piece = select_piece(board)
    next_square = target_square(select_piece, end_notation, board)

    end_square = board.board[next_square[0]][next_square[1]]

    unless end_square == ''
      @captured << end_square.symbol
      end_square.coord = nil
    end

    board.board[next_square[0]][next_square[1]] = selected_piece
    board.board[selected_piece.coord[0]][selected_piece.coord[1]] = ''
    selected_piece.coord = next_square

    selected_piece.moved = true if selected_piece.is_a?(Pawn)
    true
  end
end

class InvalidNotation < StandardError
end

class InvalidPiece < StandardError
end
