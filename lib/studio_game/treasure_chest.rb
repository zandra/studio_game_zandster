module StudioGame
  module TreasureChest
    Treasure = Data.define(:name, :value)

    TREASURES = [
      Treasure.new("pie", 10),
      Treasure.new("coin", 25),
      Treasure.new("flute", 50),
      Treasure.new("compass", 65),
      Treasure.new("key", 80),
      Treasure.new("crown", 90),
      Treasure.new("star", 100)
    ]

    def self.find_treasure
      TREASURES.sample
    end

    def self.treasure_items 
      TREASURES.map { |t| "#{t.name.capitalize.ljust(8, " ")} #{t.value} points"}
    end

  end
end