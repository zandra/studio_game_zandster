module StudioGame
  module Playable

    def boost = self.health += 15
    def drain = self.health -= 10
    def super_boost = self.health += 50

  end
end