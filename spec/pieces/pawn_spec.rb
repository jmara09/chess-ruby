require_relative '../../loader'

describe Pawn do
  subject(:pawn) { described_class.new }
  let(:chess_board) { Array.new(3) { Array.new(3) { { piece: nil } } } }

  describe '#check_diagonal' do
    context 'if there is an opponent positioned diagonally' do
      let(:opponent_pawn) { instance_double(Pawn) }

      before do
        chess_board[1][0][:piece] = opponent_pawn
        chess_board[1][2][:piece] = opponent_pawn
        allow(opponent_pawn).to receive(:player).and_return(2)
        allow(pawn).to receive(:convert_notation).and_return([2, 1])
      end

      context 'when the opponent is on the left diagonal' do
        it 'the delta for left diagonal is included' do
          player = pawn.player
          left_diagonal = [-1, -1]
          result = pawn.check_diagonal(chess_board, player)
          expect(result).to include(left_diagonal)
        end
      end

      context 'when the opponent in on the right diagonal' do
        it 'the delta for left diagonal is included' do
          player = pawn.player
          right_diagonal = [-1, +1]
          result = pawn.check_diagonal(chess_board, player)
          expect(result).to include(right_diagonal)
        end
      end

      context 'when there is two opponent positioned diagonally' do
        it 'returns both deltas' do
          player = pawn.player
          both_diagonal = [[-1, -1], [-1, +1]]
          result = pawn.check_diagonal(chess_board, player)
          expect(result).to eq(both_diagonal)
        end
      end
    end

    context 'if the square is empty' do
      before do
        allow(pawn).to receive(:convert_notation).and_return([2, 1])
      end

      it 'returns nothing' do
        player = pawn.player
        result = pawn.check_diagonal(chess_board, player)
        expect(result).to be_empty
      end
    end

    context 'if there is a piece from the same player' do
      let(:friendly_piece) { instance_double(Pawn) }

      before do
        chess_board[1][0][:piece] = friendly_piece
        allow(friendly_piece).to receive(:player).and_return(pawn.player)
        allow(pawn).to receive(:convert_notation).and_return([2, 1])
      end

      it 'returns nothing' do
        player = pawn.player
        result = pawn.check_diagonal(chess_board, player)
        expect(result).to be_empty
      end
    end
  end

  describe '#deltas' do
    before do
      allow(pawn).to receive(:convert_notation).and_return([2, 1])
    end

    context 'if moved is false' do
      it 'returns a delta used to move two squares forward' do
        two_squares_ahead = [-2, 0]
        result = pawn.deltas(chess_board, pawn.player)
        expect(result).to include(two_squares_ahead)
      end
    end

    context 'if the return value of #check_diagonal is not empty' do
      context 'when there is two deltas returned' do
        before do
          allow(pawn).to receive(:check_diagonal).and_return([[-1, -1], [-1, 1]])
        end

        it 'will be included in the return value' do
          left_diagonal = [-1, -1]
          right_diagonal = [-1, 1]
          result = pawn.deltas(chess_board, pawn.player)
          expect(result).to include(left_diagonal).and include(right_diagonal)
        end
      end

      context 'when only one is returned' do
        before do
          allow(pawn).to receive(:check_diagonal).and_return([[-1, -1], [-1, 1]])
        end

        it 'will be included in the return value' do
          left_diagonal = [-1, -1]
          result = pawn.deltas(chess_board, pawn.player)
          expect(result).to include(left_diagonal)
        end
      end

      context 'when there is no return value from #check_diagonal' do
        before do
          allow(pawn).to receive(:check_diagonal).and_return([])
        end

        it 'is not included in the return value' do
          left_diagonal = [-1, -1]
          right_diagonal = [-1, 1]
          result = pawn.deltas(chess_board, pawn.player)
          expect(result).not_to include(left_diagonal, right_diagonal)
        end
      end
    end
  end
end
