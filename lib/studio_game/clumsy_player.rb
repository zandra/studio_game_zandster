require_relative "player"

module StudioGame
  class ClumsyPlayer < Player

    attr_reader :boost_factor

    def initialize(name, health=50)
      super(name, health)
      @boost_factor = 0
    end

    def add_treasure(name, value)
      value = value / 2
      super(name, value)
    end

    def boost
      @boost_factor += 1
      puts "#{@name}'s boost was worth #{@boost_factor * 15} points!"
      @health += @boost_factor * 15
    end

  end
end

if __FILE__ == $0
  clumsy = StudioGame::ClumsyPlayer.new("klutz")

  clumsy.add_treasure("flute", 50)
  clumsy.add_treasure("flute", 50)
  clumsy.add_treasure("flute", 50)
  clumsy.add_treasure("star", 100)

  clumsy.treasure_found.each do |name, points|
    puts "#{name}: #{points} points"
  end

  puts "#{clumsy.points.to_i} total points"

  puts "Current health #{clumsy.health}"

  3.times {clumsy.boost}

  puts "Current health #{clumsy.health}"
end