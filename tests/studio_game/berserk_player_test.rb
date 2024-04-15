require  "minitest/autorun"
require_relative "../../lib/studio_game/player"
require_relative "../../lib/studio_game/berserk_player"

module StudioGame
  class BerserkPlayerTest < Minitest::Test
    def setup
      @player = BerserkPlayer.new("conan", 50)

      $stdout = StringIO.new
    end

    def test_starts_with_0_boost_count
      assert_equal 0, @player.boost_count 
    end

    def test_player_is_not_initially_berserk
      refute @player.berserk?
    end

    def test_boosted_player_becomes_berserk
      6.times {@player.boost}
      assert @player.berserk?
    end

    def test_berserk_player_is_boosted_when_drained
      6.times {@player.boost}
      @player.drain
      assert_equal (50+(7*15)), @player.health
    end
    
  end
end
