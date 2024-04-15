require_relative "player"

module StudioGame
  class BerserkPlayer < Player

    attr_reader :boost_count

    def initialize(name, health=50) 
      super(name, health)
      @boost_count = 0
    end

    def berserk? 
      @boost_count > 5
    end

    def boost
      super
      @boost_count += 1
      puts "#{@name} is berserk!" if berserk?
    end

    def drain
      if berserk?
        boost
      else
        super
      end
    end

    ## ^ another way 
    # def drain
    #   berkserk? ? boost : super
    # end

  end
end

if __FILE__ == $0
  berserker = StudioGame::BerserkPlayer.new("bubbles", 50)
  puts berserker
  2.times {berserker.drain}
  puts "#{berserker.name} got drained and now has a health of #{berserker.health}"
  10.times {berserker.boost}
  puts "#{berserker.name} has been boosted #{berserker.boost_count} times"
  puts "#{berserker.name} has a health of #{berserker.health}"

  2.times {berserker.drain}
  puts "#{berserker.name} cannot be drained! She now has a health of #{berserker.health}"
end