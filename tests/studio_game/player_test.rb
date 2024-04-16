require "minitest/autorun"
require_relative "../../lib/studio_game/player"

module StudioGame
  class PlayerTest < Minitest::Test

    def setup
      @player = Player.new("princess bubblegum", 100)
    end

    def test_has_a_capitalized_name
      assert_equal "Princess Bubblegum", @player.name
    end

    def test_has_an_initial_health
      assert_equal 100, @player.health
    end

    def test_output_of_to_string
      assert_equal "Princess Bubblegum with health = 100, points = 0, and score = 100", @player.to_s
    end

    def test_initally_has_no_treasures
      assert @player.treasure_found.empty?
    end

    def test_initial_pie_count_is_zero
      assert_equal 0, @player.pies_found 
    end

    def test_find_a_pie
      2.times do
        @player.find_a_pie
      end
      assert_equal 2, @player.pies_found 
    end

    def test_boost_increases_health_by_15
      @player.boost

      assert_equal 115, @player.health
    end

    def test_super_boost_increases_health_by_50
      @player.super_boost

      assert_equal 150, @player.health
    end

    def test_drain_decreases_health_by_10
      @player.drain

      assert_equal 90, @player.health
    end

    def test_finding_treasure
      @player.add_treasure("treasure", 10)

      refute @player.treasure_found.empty?

      assert_equal ["treasure"], @player.treasure_found.keys
      assert_equal [10], @player.treasure_found.values
    end

    def test_finding_treasure_with_existing_key_adds_to_existing_value
      @player.add_treasure("treasure", 10)
      @player.add_treasure("treasure", 10)

      assert_equal [20], @player.treasure_found.values
    end

  end
end