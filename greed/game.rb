require_relative('./dice_set')
require_relative('./player')

class Game
  attr_reader :players

  def initialize
    @players = []
    @dice_set = DiceSet.new
    @final_round_tickets = 0
  end

  def play
    welcoming_message
    reset_players_opennings
    start_game
    end_game
  end

  def welcoming_message
    puts "Welcome to Greed Dice Game!"
  end

  def reset_players_opennings
    players.each(&:reset_openning)
  end

  def start_game
    play_round until game_over?
  end

  def play_round
    players.each do |player|
      if final_round?
        return if game_over?
        @final_round_tickets += 1
      end

      print "\nPlayer #{player.name}: "

      if player.in?
        turn_to(player)
      else
        get_in_the_game(player)
      end
    end
  end

  def turn_to(player, first_round = false)
    farkled, banked = false, false
    num_of_dice = (first_round &&
      !dice_set.hot_dice? ? dice_set.non_scoring_dice : 5)

    until farkled || banked
      response = player.respond_to_roll
      case response
      when :roll
        update_info(player, :roll, num_of_dice)
        num_of_dice = (dice_set.hot_dice? ? 5 : dice_set.non_scoring_dice)
        farkled = farkled?(player)
      when :bank
        update_info(player, :bank)
        winning_point_check(player)
        banked = true
      end
    end
  end

  def farkled?(player)
    if dice_set.score == 0
      player.accum_points = 0
      return true
    end

    false
  end

  def update_info(player, response, num_of_dice = nil)
    if response == :roll
      puts "Player #{player.name}: "
      puts "Number of Dice: #{num_of_dice}"
      puts "Throw: #{dice_set.roll(num_of_dice)}"
      puts "Score: #{dice_set.score} points"
      player.accum_points += dice_set.score
      puts "Remaining Non-score Dice: #{dice_set.non_scoring_dice}"
      puts "Your Accum Score So Far: #{player.accum_points}"
      puts "Your Total Score: #{player.total_points}"
    else
      player.bank_accum_points
      puts "Player #{player.name}'s Total Score: #{player.total_points}"
    end
  end

  def get_in_the_game(player)
    puts "You must achieve at least 300 points to begin."
    response = player.respond_to_roll
    case response
    when :roll
      puts "Player #{player.name}: "
      puts "Throw: #{dice_set.roll}"
      puts "Score: #{dice_set.score} points"
      threshold_check(player)
    when :bank
    end
  end

  def threshold_check(player)
    if dice_set.score >= 300
      puts "You're in!"
      player.get_in
      player.accum_points += dice_set.score
      puts "Your Accum Score: #{player.accum_points}"
      turn_to(player, true)
    else
      puts "Sorry, you didn't make it. Good luck on the next round!"
    end
  end

  def game_over?
    final_round_tickets == players.count
  end

  def final_round?
    final_round_tickets != 0
  end

  def winning_point_check(player)
    if !final_round? && player.total_points >= 3000
      puts "\nEnter the final round:"
      @final_round_tickets += 1
    end
  end

  def end_game
    show_info
    puts "\nWINNER is: " +
      "Player #{winner.name} with a total score #{winner.total_points}!"
  end

  def winner
    players.sort.last
  end

  def show_info
    puts "Player         Total Score"
    puts "-----------    -----------"

    players.each do |player|
      printf("%.11s %12s", "Player #{player.name}:",
        "#{player.total_points}\n")
    end
  end

  def add_players(n = 2, *args)
    n.times do |i|
      # rand(360000).to_s(36): randomly generates some strings.
      name = args[i] || rand(360000).to_s(36)
      @players << Player.new(name)
    end

    @players
  end

  protected
    attr_reader :dice_set, :final_round_tickets
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.add_players(3)
  game.play
end
