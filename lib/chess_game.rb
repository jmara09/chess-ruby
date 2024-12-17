require 'colorize'

require_relative 'computer'
require_relative 'player'

class ChessGame
  attr_accessor :computer, :current_player, :game_status, :player_one, :player_two

  def initialize
    @chess_board = ChessBoard.new
    @game_status = 'continue'
  end

  def update_pieces(player, opponent)
    player.active_pieces = player.active_pieces.reject { |piece| piece.coord.nil? }
    opponent.active_pieces = opponent.active_pieces.reject { |piece| piece.coord.nil? }
  end

  def start
    @chess_board.set_pieces
    player_input
    opponent = setup_opponent(@player_one.color)
    @current_player = @player_one.color == 'white' ? @player_one : opponent

    while @game_status == 'continue'
      @chess_board.print_board
      current_opponent = toggle_player(@current_player, @player_one, opponent)

      if check?(@current_player.king, current_opponent.active_pieces, @chess_board.board)
        puts "#{@current_player.color.colorize(:blue)} is in check"
      end

      play_turn(@current_player)
      update_pieces(@player_one, opponent)

      if current_opponent.king.coord.nil? || opponent_check_mate?(current_opponent.king, @current_player.active_pieces,
                                                                  current_opponent.active_pieces, @chess_board.board)
        @chess_board.print_board
        puts "#{@current_player.color.capitalize.colorize(:blue)} wins!"

        if replay
          reset
          start
        end

        @game_status = 'exit'
      end

      process_game_status
      @current_player = toggle_player(@current_player, @player_one, opponent)
    end
  end

  def reset
    @chess_board = ChessBoard.new
    @game_status = 'continue'
    @player_one = nil
    @player_two = nil
    @computer = nil
  end

  def replay
    loop do
      print 'Play another game? [y/n] '
      input = gets.chomp.downcase
      next unless %w[y n].include?(input)
      return true if input == 'y'

      return false
    end
  end

  def toggle_player(current, player_one, player_two)
    current == player_one ? player_two : player_one
  end

  def check?(king, enemy_pieces, board)
    return false if enemy_pieces.empty?

    enemy_pieces.any? do |piece|
      piece.available_squares(board).include?(king.coord)
    end
  end

  def path_to_king(king_coord, opponent_coord)
    row_offset = opponent_coord[0] <=> king_coord[0]
    col_offset = opponent_coord[1] <=> king_coord[1]
    current_square = king_coord
    paths = []

    until current_square == opponent_coord
      current_square = [
        row_offset + current_square[0],
        col_offset + current_square[1]
      ]

      puts current_square
      paths << current_square
    end

    paths
  end

  def opponent_check_mate?(enemy_king, own_pieces, enemy_pieces, board)
    return false unless check?(enemy_king, own_pieces, board)
    return false if own_pieces.empty?

    enemy_king_moves = enemy_king.available_squares(board)
    all_own_moves = own_pieces.flat_map { |piece| piece.available_squares(board) }

    enemy_king_safe = enemy_king_moves.any? { |enemy_king_move| !all_own_moves.include?(enemy_king_move) }
    return false if enemy_king_safe

    attackers = own_pieces.select do |own_piece|
      own_piece.available_squares(board).include?(enemy_king.coord)
    end

    return true if attackers.size > 1

    paths = if attackers.first.is_a?(Knight)
              [attackers.first.coord]
            else
              path_to_king(enemy_king.coord, attackers.first.coord)
            end

    all_enemy_moves = enemy_pieces.flat_map do |piece|
      next [] if piece.is_a?(King)

      piece.available_squares(board)
    end

    block_or_capture = paths.any? { |square| all_enemy_moves.include?(square) }

    !block_or_capture
  end

  def process_game_status
    case @game_status
    when 'save'
      # implement saving
    when 'exit'
      puts 'Exiting game'
      exit
    end
  end

  def choose_color
    input = nil
    loop do
      print 'Which color of piece would you like to play with? [w/b] '
      input = gets.chomp
      puts

      redo unless %w[w b].include?(input)

      input = input == 'w' ? 'white' : 'black'
      puts "You will play as #{input.colorize(:blue)}"
      puts
      break
    end
    input
  end

  def player_input
    color = choose_color
    king = @chess_board.send(:"#{color}_king")
    pieces = @chess_board.send(:"#{color}_pieces")
    @player_one = Player.new(color, king, pieces)
  end

  def setup_opponent(player_one)
    opponent_color = player_one == 'white' ? 'black' : 'white'
    king = @chess_board.send(:"#{opponent_color}_king")
    pieces = @chess_board.send(:"#{opponent_color}_pieces")

    loop do
      print 'Would you like to play against another player? [y/N] '
      input = gets.chomp.downcase

      redo unless ['y', 'n', ''].include?(input)

      if input == 'y'
        @player_two = Player.new(opponent_color, king, pieces)
        return @player_two
      elsif ['n', ''].include?(input)
        @computer = Computer.new(opponent_color, king, pieces)
        return @computer
      end
    end
  end

  def play_turn(current_player)
    puts "Turn of #{current_player.color.colorize(:blue)}"

    if current_player.is_a?(Player)
      @game_status = current_player.move(@chess_board)
    else
      puts 'Computer is thinking..'
      sleep(1)
      @computer.random_move(@chess_board.board)
      puts 'Computer makes a move'
      sleep(1)
    end
  end
end

chess = ChessGame.new
chess.start
