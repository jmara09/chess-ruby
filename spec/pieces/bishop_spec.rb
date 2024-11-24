require_relative '../../loader'

describe Bishop do
  subject(:bishop) { described_class.new }
  let(:chess_board) { ChessBoard.new.board }
  let(:own_piece) { double('pawn', player: 1) }
  let(:enemy_piece) { double('pawn', player: 2) }
end
