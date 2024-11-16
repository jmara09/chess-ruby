require_relative '../../lib/pieces/load_pieces'

describe Piece do
  subject(:piece) { described_class.new }
  describe '#convert_notation' do
    context 'when a valid position is received' do
      before do
        piece.notation = 'a1'
      end

      it 'converts it into an array and position from array' do
        position = piece.notation
        position_from_array = [7, 0]
        converted = piece.convert_notation(position)
        expect(converted).to be_an(Array).and eq(position_from_array)
      end
    end

    context 'when an invalid position is received' do
      context 'when the input is out of bounds' do
        before do
          piece.notation = 'z9'
        end

        it 'return an error message' do
          position = piece.notation
          error_message = 'Invalid input.'
          expect(piece).to receive(:puts).with(error_message)
          piece.convert_notation(position)
        end
      end

      context 'when the input is a long string' do
        before do
          piece.notation = 'Hello, world!'
        end

        it 'return an error message' do
          position = piece.notation
          error_message = 'Invalid input.'
          expect(piece).to receive(:puts).with(error_message)
          piece.convert_notation(position)
        end
      end
    end
  end

  describe '#available_squares' do
    context 'if the piece is a Pawn object' do
      let(:pawn) { instance_double(Pawn) }

      before do
        allow(piece).to receive(:convert_notation).and_return([6, 0])
        allow(pawn).to receive(:deltas).and_return([[-1, 0]])
      end

      it 'returns a square one row ahead' do
        deltas = pawn.deltas
        square_ahead = [5, 0]
        result = piece.available_squares(deltas)
        expect(result).to include(square_ahead)
      end
    end
  end
end
