require_relative '../../loader'

describe Pawn do
  subject(:pawn) { described_class.new }
  let(:chess_board) { ChessBoard.new.board }
  let(:own_piece) { double('knight', player: 1) }
  let(:enemy_piece) { double('knight', player: 2) }

  describe '#check_square' do
    let(:position) { [6, 1] }

    context 'if moved is false' do
      context 'when there is an enemy piece two squares ahead' do
        before do
          chess_board[4][1][:piece] = enemy_piece
        end

        it 'will return the square' do
          two_squares_ahead = [4, 1]
          delta = [-2, 0]
          result = pawn.check_square(delta, position, chess_board)
          expect(result).to include(two_squares_ahead)
        end
      end

      context 'when your own piece is on two squares ahead' do
        before do
          chess_board[4][1][:piece] = own_piece
        end

        it 'will not include two squares ahead' do
          two_squares_ahead = [4, 1]
          delta = [-2, 0]
          result = pawn.check_square(delta, position, chess_board)
          expect(result).not_to include(two_squares_ahead)
        end
      end
    end

    context 'if the delta is diagonal and the square is empty' do
      it 'returns nil' do
        upper_left_delta = [-1, -1]
        result = pawn.check_square(upper_left_delta, position, chess_board).first
        expect(result).to be_nil
      end
    end

    context 'if there is an enemy positioned diagonally' do
      context 'when the enemy piece is on upper left' do
        before do
          chess_board[5][0][:piece] = enemy_piece
        end

        it 'returns a message and the square' do
          upper_left_square = [5, 0]
          message = 'enemy piece'
          delta = [-1, -1]
          result = pawn.check_square(delta, position, chess_board)
          expect(result).to include(message, upper_left_square)
        end
      end

      context 'when the enemy piece is on upper right' do
        before do
          chess_board[5][2][:piece] = enemy_piece
        end

        it 'returns a message and the square' do
          upper_right_square = [5, 2]
          message = 'enemy piece'
          delta = [-1, 1]
          result = pawn.check_square(delta, position, chess_board)
          expect(result).to include(message, upper_right_square)
        end
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
        result = pawn.deltas[:forward]
        expect(result).to include(two_squares_ahead)
      end
    end
  end

  describe

  describe '#available_squares' do
    before do
      middle_bottom = [2, 1]
      allow(pawn).to receive(:convert_notation).and_return(middle_bottom)
    end

    context 'if the deltas received are [-1, 0] and [-2, 0]' do
      xit 'returns a square directly ahead and two squares ahead' do
        deltas = [[-1, 0], [-2, 0]]
        one_square_ahead = [1, 1]
        two_squares_ahead = [0, 1]
        result = pawn.available_squares(deltas)
        expect(result).to include(one_square_ahead, two_squares_ahead)
      end
    end

    context 'if there is an enemy diagonally positioned both side' do
      xit 'returns squares where the enemy piece is positioned' do
        enemy_deltas = [[-1, -1], [-1, 1]]
        upper_left = [1, 0]
        upper_right = [1, 2]
        result = pawn.available_squares(enemy_deltas)
        expect(result).to include(upper_left, upper_right)
      end
    end
  end
end
