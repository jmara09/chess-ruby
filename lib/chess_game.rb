require_relative 'player'

class ChessGame
  attr_accessor :player_one, :player_two, :computer

  def initialize
    @player_one = nil
    @player_two = nil
    @computer = nil
    @chess_board = ChessBoard.new
  end
end
