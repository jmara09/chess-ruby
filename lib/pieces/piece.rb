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

  def available_squares(deltas)
    current_position = convert_notation
    squares = []
    deltas.each do |delta|
      square = Array.new(2, nil)
      square[0] = delta[0] + current_position[0]
      square[1] = delta[1] + current_position[1]
      squares << square
    end
    squares
  end
end
