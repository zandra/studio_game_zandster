require "csv"
require_relative "treasure_chest"
require_relative "auditable"

module StudioGame
  class Game
    include Auditable

    attr_reader :title, :players, :winner

    def initialize(title)
      @title = title.split.map(&:capitalize).join(' ')
      @players = []
      @winner = nil
    end

    def add_player(player)
      @players << player
    end
    
    def roll_die
      rand(1..6)
    end
    
    def sorted_players
      @players.sort_by {|p| p.score }.reverse
    end

    #### File read and write methods #######
    def load_players(path)
      File.readlines(path, chomp: true).each do |row|
        player = Player.from_csv(row)
        add_player(player)
      end
    rescue Errno::ENOENT
      puts "Uh-Oh, #{path} not found 😶"
      exit 1
    end
    
    ## Saves high scores to file
    def save_scores_to_file(to_file = "player_high_scores.txt" )
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        sorted_players.each do |player|
          file.puts player_high_score_formatted(player)
        end
      end 
    end

    ####### Game Scoring & Formatting ############
    ## game score => called after each set of rounds
    def print_game_stats
      puts "\n #{@title} Game Stats:"
      puts "-" * 25
      puts sorted_players
    end
    
    ## formatted scoring for each player - just formats, doesn't explicitly print
    def player_high_score_formatted(player)
      name = player.name.ljust(23, ".")
      score = player.score.to_s
      "#{name} #{score}"
    end

    def tally_high_scores
      puts "\nHigh Scores:"
      sorted_players.each do |player|
        puts player_high_score_formatted(player)
      end
    end
    
    def tally_treasures 
      sorted_players.each do |player|
        puts "\n#{player.name}'s treasure point totals:"
        treasures = player.treasure_found.map {|k,v| "#{k.capitalize}: #{v}"}
        puts treasures
        puts "TOTAL: #{player.points}"
        ### number of pies found
        puts "(Pie count: #{player.pies_found})"
      end
    end

    def declare_winner
      unless @players.empty?
        @winner = @players.max_by(&:score)
        puts "\nAnd the winner is #{@winner.name.upcase} with a score of #{@winner.score}!" 
      else
        puts "There is no winner 😶"
      end
    end 
    ##############################

    ###### Game Play ###############
    ## Game Start
    def start_game
      emoji = "🚀"
      puts "#{emoji * 25}"
      puts "\nLet's play #{@title}!\n"


      puts "\nThe available treasures are:"
      puts TreasureChest.treasure_items
      puts "Bonus: Players who find 3 pies will get a sweet treat 🥧 🥧 🥧"
    
      puts "\nBefore playing:"
      puts @players
      puts "\n"
    end

    ## Game End
    def end_game
      tally_high_scores
      "\n"
      tally_treasures
      declare_winner
      puts "\nThanks for playing #{@title}! 🎲\n\n"
    end
    
    ### Play ####
    def play_game(rounds = 1)
      start_game
      ### play
      1.upto(rounds) do |r|
        puts "Round #{r}"
        @players.each do |p|
          dice_roll = roll_die
          case dice_roll
          when 1..2
            puts "#{p.name} got drained 💔"
            p.drain
          when 3..4
            puts "#{p.name} got skipped 😐"
          else
            puts "#{p.name} got boosted 🌟"
            p.pies_found >= 3 ? p.super_boost : p.boost
          end
          ### find a treasure
          treasure = TreasureChest.find_treasure
          ### is it a pie?
          if treasure.name == "pie"
            p.find_a_pie
            puts "#{p.name} found a #{treasure.name} worth #{treasure.value} points (Pie count: #{p.pies_found})"
          else
            puts "#{p.name} found a #{treasure.name} worth #{treasure.value} points"
          end
          ### add treasure to player's points
          p.add_treasure(treasure.name, treasure.value) 
          puts "\n"
        end
      end
      print_game_stats # prints stats after each set of rounds 
    end
    ####################################################
  end
end