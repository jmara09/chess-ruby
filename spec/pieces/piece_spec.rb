require_relative '../../lib/pieces/piece'

describe Piece do
  subject(:piece) { described_class.new }
  describe '#convert_coordinates' do
    context 'when a valid position is received' do
      before do
        piece.coordinates = 'a1'
      end

      it 'converts it into an array and position from array' do
        position = piece.coordinates
        position_from_array = [7, 0]
        converted = piece.convert_coordinates(position)
        expect(converted).to be_an(Array).and eq(position_from_array)
      end
    end

    context 'when an invalid position is received' do
      context 'when the input is out of bounds' do
        before do
          piece.coordinates = 'z9'
        end

        it 'return an error message' do
          position = piece.coordinates
          error_message = 'Invalid input.'
          expect(piece).to receive(:puts).with(error_message)
          piece.convert_coordinates(position)
        end
      end

      context 'when the input is a long string' do
        before do
          piece.coordinates = 'Hello, world!'
        end

        it 'return an error message' do
          position = piece.coordinates
          error_message = 'Invalid input.'
          expect(piece).to receive(:puts).with(error_message)
          piece.convert_coordinates(position)
        end
      end
    end
  end

  describe '#available_squares' do
    context 'if the piece is a Pawn object' do
      before do
        allow(piece).to receive(:convert_coordinates).and_return([6, 0])
      end

      it 'returns a square one row ahead' do
        position = piece.convert_coordinates
        square_ahead = [position[0] - 1, position[1]]
        result = piece.available_squares
        expect(result).to eq(square_ahead)
      end
    end
  end
end
