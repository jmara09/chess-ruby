module PositionConverter
  def to_coord(notation)
    return nil if notation.nil? || notation.length != 2

    col = notation[0].downcase
    row = notation[1]

    return nil unless ('a'..'h').include?(col) && ('1'..'8').include?(row)

    converted_row = 8 - row.to_i
    converted_col = col.ord - 'a'.ord
    [converted_row, converted_col]
  end
end
