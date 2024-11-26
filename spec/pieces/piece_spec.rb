require_relative '../../loader'

describe Piece do
  subject(:piece) { described_class.new }
  let(:chess_board) { ChessBoard.new.board }

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

  describe '#check_square' do
    context 'if there is a piece of the player on the square' do
      let(:knight) { double('knight', player: 1) }

      before do
        chess_board[6][1][:piece] = knight
        allow(piece).to receive(:convert_notation).and_return([7, 1])
      end

      it 'returns a message' do
        message = 'own piece'
        delta = [-1, 0]
        position = piece.convert_notation
        result = piece.check_square(delta, position, chess_board).first
        expect(result).to eq(message)
      end
    end

    context 'if there is an enemy piece on the square' do
      let(:knight) { double('knight', player: 2) }

      before do
        chess_board[6][1][:piece] = knight
        allow(piece).to receive(:convert_notation).and_return([7, 1])
      end

      it 'returns a message and the square' do
        square_ahead = [6, 1]
        message = 'enemy piece'
        position = piece.convert_notation
        delta = [-1, 0]
        result = piece.check_square(delta, position, chess_board)
        expect(result).to include(message, square_ahead)
      end
    end

    context 'when the square is empty' do
      before do
        allow(piece).to receive(:convert_notation).and_return([7, 0])
      end

      it 'returns a message the square' do
        square_ahead = [6, 0]
        message = 'empty'
        position = piece.convert_notation
        delta = [-1, 0]
        result = piece.check_square(delta, position, chess_board)
        expect(result).to include(message, square_ahead)
      end
    end
  end

  describe '#available_squares' do
    context 'if the piece is a Pawn object' do
      let(:pawn) { instance_double(Pawn) }

      before do
        allow(pawn).to receive(:deltas).and_return({ forward: [[-1, 0]] })
        allow(piece).to receive(:convert_notation).and_return([6, 0])
        allow(piece).to receive(:check_square).and_return(['empty', [5, 0]])
      end

      it 'returns a square one row ahead' do
        deltas = pawn.deltas
        square_ahead = [5, 0]
        result = piece.available_squares(deltas, chess_board)
        expect(result).to include(square_ahead)
      end

      context 'when the piece is already on the last row' do
        before do
          allow(piece).to receive(:convert_notation).and_return([0, 1])
          allow(piece).to receive(:check_square).and_return([nil, nil])
        end

        it 'returns empty' do
          delta = { forward: [[-1, 0]] }
          result = piece.available_squares(delta, chess_board)
          expect(result).to be_empty
        end
      end
    end

    context 'if the square is occupied by your piece' do
      let(:knight) { instance_double(Knight) }
      let(:one_square_ahead) { [1, 1] }

      before do
        allow(piece).to receive(:convert_notation).and_return([2, 1])
        allow(knight).to receive(:player).and_return(1)
        chess_board[one_square_ahead[0]][one_square_ahead[1]][:piece] = knight
      end

      it 'will not include that square' do
        delta = { forward: [[-1, 0]] }
        squares = piece.available_squares(delta, chess_board)
        expect(squares).not_to include(one_square_ahead)
      end
    end
  end
end
