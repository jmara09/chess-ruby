class Piece
  attr_reader :symbol
  attr_accessor :notation, :moved, :player

  def initialize(notation = nil, player = 1, symbol = nil)
    @player = player
    @notation = notation
    @symbol = symbol
    @moved = false
  end

  def convert_notation(position = notation)
    return puts 'Error input. Position is nil' if position.nil?

    col = position.chars.first
    row = position.chars.last.to_i
    unless position.chars.length == 2 && (col.between?('a', 'h') && row.between?(0, 7))
      puts 'Invalid input.'
      return
    end

    last_row = 8
    columns = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    converted_row = last_row - row
    converted_col = columns[col.to_sym]
    [converted_row, converted_col]
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
    current_position = convert_notation
    squares = {}
    delta_group.each do |key, deltas|
      squares[key] = []
      deltas.each do |delta|
        result = check_square(delta, current_position, board)
        next if result.first.nil?
        break if result.first == 'own piece'

        squares[key] << result.last
        break if result.first == 'enemy piece'
      end
    end
    squares
  end
end
