require_relative '../../loader'

describe Rook do
  subject(:rook) { described_class.new }
  let(:chess_board) { ChessBoard.new.board }
  let(:own_piece) { double('rook', player: 1) }
  let(:enemy_piece) { double('rook', player: 2) }
end
