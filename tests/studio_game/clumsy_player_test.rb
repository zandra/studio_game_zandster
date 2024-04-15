require  "minitest/autorun"
require_relative "../../lib/studio_game/player"
require_relative "../../lib/studio_game/clumsy_player"

module StudioGame
  class ClumsyPlayerTest < Minitest::Test
    def setup
      @player = ClumsyPlayer.new("klutz", 50)

      $stdout = StringIO.new
    end

    def test_treasure_is_worth_half_value
      @player.add_treasure("treasure", 10)

      assert_equal [5], @player.treasure_found.values
    end

  end
end