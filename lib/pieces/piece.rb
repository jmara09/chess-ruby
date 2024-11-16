class Piece
  attr_reader :symbol
  attr_accessor :coordinates, :moved

  def initialize(position = nil, symbol = nil)
    @coordinates = position
    @symbol = symbol
    @moved = false
  end

  def convert_coordinates(position = coordinates)
    col_from_coord = position.chars.first
    row_from_coord = position.chars.last.to_i
    unless position.chars.length == 2 && (col_from_coord.between?('a', 'h') && row_from_coord.between?(0, 7))
      puts 'Invalid input.'
      return
    end

    last_row = 8
    columns = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    converted_row = last_row - row_from_coord
    converted_col = columns[col_from_coord.to_sym]
    [converted_row, converted_col]
  end

  def available_squares(edges)
    current_position = convert_coordinates
  end
end
