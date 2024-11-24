require_relative '../../loader'

describe Knight do
  subject(:knight) { described_class.new }
  let(:chess_board) { ChessBoard.new.board }
  let(:own_piece) { double('knight', player: 1) }
  let(:enemy_piece) { double('knight', player: 2) }

  describe '#check_square' do
    let(:position) { [6, 1] }

    context 'if the square is out of bounds' do
      it 'returns nil' do
        delta = [-1, -2]
        result = knight.check_square(delta, position, chess_board).first
        expect(result).to be_nil
      end
    end

    context 'if the square is empty' do
      it 'returns the square' do
        delta = [-2, 1]
        square = [
          delta[0] + position[0],
          delta[1] + position[1]
        ]
        result = knight.check_square(delta, position, chess_board)
        expect(result).to include(square)
      end
    end

    context 'if the square has a piece' do
      context 'when the piece is your own' do
        before do
          chess_board[4][2][:piece] = own_piece
        end

        it 'returns nil' do
          delta = [-2, 1]
          result = knight.check_square(delta, position, chess_board).first
          expect(result).to be_nil
        end
      end

      context 'when the piece is an enemy' do
        before do
          chess_board[4][2][:piece] = enemy_piece
        end

        it 'returns the square' do
          square = [4, 2]
          delta = [-2, 1]
          result = knight.check_square(delta, position, chess_board)
          expect(result).to include(square)
        end
      end
    end
  end
end
