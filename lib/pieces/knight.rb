class Knight
  def initialize(notation = nil, player = 1)
    white_knight = "\u2658"
    black_knight = "\u265E"
    symbol = player == 1 ? white_knight : black_knight
    super(notation, player, symbol)
  end
end
