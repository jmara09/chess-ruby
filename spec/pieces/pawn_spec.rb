require_relative '../../lib/pieces/pawn'

describe Pawn do
  subject(:pawn) { described_class.new }
  describe '#deltas' do
    context 'if moved is false' do
      it 'returns a delta used to move two squares forward' do
        two_squares_ahead = [-2, 0]
        result = pawn.deltas
        expect(result).to include(two_squares_ahead)
      end
    end
  end
end
