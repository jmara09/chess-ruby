require_relative '../../loader'

describe Pawn do
  subject(:pawn) { described_class.new }
  let(:chess_board) { Array.new(3) { Array.new(3) { { piece: nil } } } }

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
