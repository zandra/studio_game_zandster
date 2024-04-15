#### If a boosted player finds the pie 3 times, their boost kicks in
## a boosted player with a boost will get 3 times the health when boosted
## Essentially this would involve changing the instance of a parent class into an instance of a child class: either
## the instance would remain the same (not sure if this is possible) or
## the a new instance would be created and it would inherit all the properties of the original instance
require_relative "player"

module StudioGame
  class BoostedPlayer < Player

    def initialize(name, health=50, boost_factor=3)
      super(name, health)
      @boost_factor = boost_factor
      @pies_found = 0
    end

    def find_a_pie
      
    end
  end
end