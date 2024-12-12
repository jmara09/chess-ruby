require 'colorize'

require_relative 'computer'
require_relative 'player'

class ChessGame
  attr_accessor :player_one, :player_two, :computer, :winner, :game_status

  def initialize
    @player_one = nil
    @player_two = nil
    @computer = nil
    @chess_board = ChessBoard.new
    @game_status = 'continue'
    @winner = nil
  end

  def start
    @chess_board.set_pieces
    player_input
    opponent = setup_opponent(@player_one.color)
    current_player = @player_one.color == 'white' ? @player_one : opponent

    while @game_status == 'continue'
      @chess_board.update_pieces
      @chess_board.print_board
      play_turn(current_player)
      handle_checkmate(@player_one, opponent)
      handle_check(@player_one, opponent)
      process_game_status
      current_player = current_player == @player_one ? opponent : @player_one
    end
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

  def handle_checkmate(player, opponent)
    players = [player, opponent]

    threatened_player = players.find do |participant|
      attacker = participant == player ? opponent : player
      participant.king.check_mate(attacker.active_pieces, @chess_board.board)
    end

    return unless threatened_player

    @winner = (threatened_player == player ? opponent : player).color
    puts "#{@winner.colorize(:blue).capitalize} wins!"
    @game_status = 'exit'
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
      print 'Would you like to play against another player? [y/n] '
      input = gets.chomp

      redo unless %w[y n].include?(input)

      if input == 'y'
        @player_two = Player.new(opponent_color, king, pieces)
        return @player_two
      else
        @computer = Computer.new(opponent_color, king, pieces)
        return @computer
      end
    end
  end

  def handle_check(player, opponent)
    players_in_check = [player, opponent].select do |participant|
      attacker = participant == player ? opponent : player
      participant.king.check?(attacker.active_pieces, @chess_board.board)
    end

    case players_in_check.size
    when 2
      puts 'Both are in check'
    when 1
      puts "#{players_in_check.first.color} is in check"
    end
  end

  def play_turn(current_player)
    puts "Turn of #{current_player.color.colorize(:blue)}"

    if current_player.is_a?(Player)
      @game_status = current_player.move(@chess_board)
    else
      @computer.random_move(@computer.random_piece, @chess_board.board)
    end
  end
end

chess = ChessGame.new
chess.start
