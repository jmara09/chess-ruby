module FileManager
  def save_game(object)
    print 'Name your save file: '
    name = gets.chomp
    file_location = "save_files/#{name}.yaml"

    catch(:continue) do
      if File.exist?(file_location)
        input = nil

        loop do
          print "#{name} already exist. Overwrite? [y/n] "
          input = gets.chomp
          next unless %w[y n].include?(input)

          throw :continue unless input == 'n'

          save_game
        end
      end
    end

    File.open(file_location, 'w') do |file|
      file.puts YAML.dump({  chess_board: object.chess_board,
                             computer: object.computer,
                             current_player: object.current_player,
                             opponent: object.opponent,
                             game_status: object.game_status,
                             player_one: object.player_one,
                             player_two: object.player_two })
    end

    puts 'File saved successfully'
    sleep(1)
  end

  def load_game(object)
    print 'Type the name of the saved file to load: '
    name = gets.chomp
    file_location = "save_files/#{name}.yaml"

    if File.exist?(file_location)
      begin
        data = YAML.load_file(file_location)
        object.chess_board = data[:chess_board]
        object.computer = data[:computer]
        object.current_player = data[:current_player]
        object.opponent = data[:opponent]
        object.game_status = data[:game_status]
        object.player_one = data[:player_one]
        object.player_two = data[:player_two]
        puts 'Load game successfully'
        # sleep(1)
        true
      rescue StandardError => e
        puts "An error occurred while loading the game: #{e.message}"
        sleep(1)
      end
    else
      puts 'File does not exist'
      puts
      loop do
        print 'Retry? [y/n]'
        input = gets.chomp
        next unless %w[y n].include?(input)

        case input
        when 'y' then load_game
        when 'n' then false
        end
      end
    end
  end
end
