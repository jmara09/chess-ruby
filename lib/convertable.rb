module Convertable
  def to_coord(notation)
    return 'Invalid' if notation.nil?

    col = notation.chars.first
    row = notation.chars.last.to_i
    return 'Invalid' unless notation.chars.length == 2 && (col.between?('a', 'h') && row.between?(0, 7))

    last_row = 8
    columns = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    converted_row = last_row - row
    converted_col = columns[col.to_sym]
    [converted_row, converted_col]
  end
end
