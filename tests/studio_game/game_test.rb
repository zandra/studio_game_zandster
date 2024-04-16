require  "minitest/autorun"
require_relative "../../lib/studio_game/player"
require_relative "../../lib/studio_game/game"

module StudioGame
  class GameTest < Minitest::Test
    
    def setup 
      @game = Game.new("fiddle stix")
      @player_1 = Player.new("Alpha", 10)
      @player_2 = Player.new("Beta", 20)

      ## this takes the text output and puts into a new blob instead of writing to console (i.e. used to suppress output)
      $stdout = StringIO.new
    end

    def test_has_a_capitalized_title
      assert_equal "Fiddle Stix", @game.title
    end

    def test_has_no_players_initially
      assert_empty @game.players
    end

    def test_add_players_to_game
      @game.add_player(@player_1)
      @game.add_player(@player_2)

      refute_empty @game.players
      assert_equal [@player_1, @player_2], @game.players
    end

    def test_high_number_rolled_boosts_player_health
      @game.add_player(@player_1)
      @game.stub(:roll_die, 5) do
        ## intial health of 10 is boosted by 15 to equal 25
        @game.play_game()
        assert_equal 25, @player_1.health 
      end
    end

    def test_low_number_rolled_drains_player_health
      @game.add_player(@player_1)
      @game.stub(:roll_die, 2) do
        ## intial health of 10 is drained by 10 to equal 0
        @game.play_game()
        assert_equal 0, @player_1.health 
      end
    end

    def test_high_number_rolled_super_boosts_player_health_if_pie_count_is_three
      @game.add_player(@player_1)
      @player_1.pies_found = 3
      @game.stub(:roll_die, 5) do
        ## intial health of 10 is boosted by 50 to equal 60
        @game.play_game()
        assert_equal 60, @player_1.health 
      end
    end

    def test_high_number_rolled_does_not_super_boost_player_health_if_pie_count_is_under_three
      @game.add_player(@player_1)
      @player_1.pies_found = 2
      @game.stub(:roll_die, 5) do
        ## intial health of 10 is boosted by 15 to equal 25
        @game.play_game()
        assert_equal 25, @player_1.health 
      end
    end

    def test_highest_score_player_wins
      @game.add_player(@player_1)
      @game.add_player(@player_2)

      @game.declare_winner()

      assert_equal @player_2, @game.winner
    end

  end
end