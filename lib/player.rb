require_relative 'chess_board'

class Player
  attr_accessor :active_pieces
  attr_reader :color, :captured, :king

  def initialize(color, king, pieces)
    @color = color
    @king = king
    @active_pieces = pieces
    @captured = []
  end

  def to_coord(notation)
    return nil if notation.nil? || notation.length != 2

    col = notation[0].downcase
    row = notation[1]

    return nil unless ('a'..'h').include?(col) && ('1'..'8').include?(row)

    converted_row = 8 - row.to_i
    converted_col = col.ord - 'a'.ord
    [converted_row, converted_col]
  end

  def valid_piece?(coord, board)
    raise InvalidNotation unless coord

    square = board.board[coord[0]][coord[1]]
    raise InvalidPiece if square == '' || square.color != color

    true
  end

  def check_for_save_or_exit(input)
    return input if %w[save exit].include?(input)

    nil
  end

  def select_piece(board)
    loop do
      print 'Please select a piece (e.g., "a1"): '
      input = gets.chomp
      return input if check_for_save_or_exit(input)
      next if input.empty?

      coord = to_coord(input)

      begin
        valid_piece?(coord, board)
        piece = board.board[coord[0]][coord[1]]
        legal_moves = piece.available_squares(piece.deltas, board.board, color)

        if legal_moves.empty?
          puts "#{piece.class} at #{input} has no available moves."
          next
        end

        board.print_board(legal_moves)

        return piece
      rescue InvalidNotation, InvalidPiece => e
        puts e.message
      end
    end
  end

  def target_square(piece, board)
    print 'Type redo to change or the next notation to make a move: '
    notation = gets.chomp

    loop do
      return notation if notation == 'redo' || check_for_save_or_exit(notation)

      coord = to_coord(notation)
      if coord.nil?
        puts 'Invalid notation. Please try again:'
      elsif piece.available_squares(piece.deltas, board.board, color).include?(coord)
        return coord
      else
        puts 'Illegal move. Please try again:'
      end
      notation = gets.chomp
    end
  end

  def move(board)
    selected_piece = select_piece(board)
    return selected_piece if check_for_save_or_exit(selected_piece)

    next_square = target_square(selected_piece, board)
    raise Redo if next_square == 'redo'
    return next_square if check_for_save_or_exit(next_square)

    end_square = board.board[next_square[0]][next_square[1]]

    unless end_square == ''
      @captured << end_square.symbol
      end_square.coord = nil
    end

    board.board[next_square[0]][next_square[1]] = selected_piece
    board.board[selected_piece.coord[0]][selected_piece.coord[1]] = ''
    selected_piece.coord = next_square

    selected_piece.moved = true if selected_piece.is_a?(Pawn)
    'continue'
  rescue Redo
    board.print_board
    retry
  end
end

class Redo < StandardError
end

class InvalidNotation < StandardError
  def message
    'The notation you entered is not valid. Please enter a valid chess notation (e.g., "a1").'
  end
end

class InvalidPiece < StandardError
  def message
    'The selected piece is either not yours or is invalid. Please try again.'
  end
end
