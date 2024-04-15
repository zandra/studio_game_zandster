require_relative "playable"


module StudioGame
  class Player
    include Playable

    attr_reader :treasure_found, :points
    attr_accessor :name, :health

    def initialize(name, health=50)
      @name = name.split.map(&:capitalize).join(' ')
      @health = health
      @treasure_found = Hash.new(0)
    end

    def formatted_name(name)
      name.split.map(&:capitalize).join(' ')
    end

    def add_treasure(name, value)
      @treasure_found[name] += value
    end

    def name=(new_name)
      @name = new_name.split.map(&:capitalize).join(' ')
    end

    def to_s = "#{@name} with health = #{@health}, points = #{points}, and score = #{score}"

    def points
      @treasure_found.values.sum
    end

    def score 
      @health + points
    end


    def self.from_csv(line)
      name, health = line.split(",")
      Player.new(name, Integer(health))
    rescue ArgumentError => error
      puts error
      puts "#{name} will be give an initial health of 35."
      Player.new(name, health = 35)
    end


      ### Only called if this file is run directly
      if __FILE__ == $0
        player = Player.new("princess bubblegum", 80)
        puts "Player name: #{player.name}"
        puts "Player health: #{player.health}"
        player.boost
        puts "Health after boosting: #{player.health}"
        player.drain
        puts "Health after draining: #{player.health}"
      end
  end
end