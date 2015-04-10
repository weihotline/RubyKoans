require File.expand_path(File.dirname(__FILE__) + '/neo')
require_relative './GREED/game'

class GreedTest < Neo::Koan
  # Player class
  def test_can_create_a_player
    player = Player.new("John")
    assert_not_nil player
    assert_equal "John", player.name
    assert_equal 0, player.total_points
    assert_equal 0, player.accum_points
  end

  def test_bank_accumulated_score_so_far_to_total_points
    player = Player.new("Tom")

    player.accum_points = 100
    total_points = player.bank_accum_points
    assert_equal 100, total_points
    assert_equal 0, player.accum_points

    player.accum_points = 400
    total_points = player.bank_accum_points
    assert_equal 500, total_points
  end

  def test_player_openning_status
    player = Player.new("Jim")
    assert_equal nil, player.in?

    player.reset_openning
    assert_equal false, player.in?

    player.get_in
    assert_equal true, player.in?
  end

  def test_spaceship_operator_on_player
    player1 = Player.new("John")
    player1.accum_points = 200
    player1.bank_accum_points

    player2 = Player.new("Sam")
    player2.accum_points = 400
    player2.bank_accum_points

    assert_equal -1, player1.<=>(player2)
    assert_equal 1, player2.<=>(player1)
  end

  # DiceSet
  def test_hot_dice
    dice_set = DiceSet.new

    10.times {
      if [ [1], [5] ].include?(dice_set.roll(1))
        assert [ 100, 50 ].include?(dice_set.score)
        assert_equal true, dice_set.hot_dice?
      else
        assert_equal false, dice_set.hot_dice?
      end
    }
  end

  # Game
  def test_can_create_a_new_game
    game = Game.new
    assert_not_nil game
  end

  def test_adding_players_to_the_game
    game = Game.new
    players = game.add_players(3, "John", "Jim", "Joe")
    assert_equal "John", players[0].name
    assert_equal "Jim", players[1].name
    assert_equal "Joe", players[2].name
    assert_equal 3, players.size

    # add two more players
    game.add_players(2)
    assert_equal 5, players.size
  end

  def test_final_round
    game = Game.new
    assert_equal false, game.final_round?
  end

  def test_game_over
    game = Game.new
    game.add_players(2)
    assert_equal false, game.game_over?
  end

  def test_winner_method
    game = Game.new
    players = game.add_players(2)
    player1 = players[0]

    player1.accum_points = 3000
    player1.bank_accum_points

    assert_equal player1, game.winner
  end

  def test_resetting_players_opennings
    game = Game.new
    players = game.add_players(3)
    game.reset_players_opennings

    assert_equal true, players.all? { |p| p.in? == false }
  end

  def test_update_info_about_the_throw
    game = Game.new
    player = Player.new("John")
    player.accum_points = 200

    game.update_info(player, :bank)
    assert_equal 200, player.total_points
  end
end
