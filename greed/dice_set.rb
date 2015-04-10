class DiceSet
  attr_reader :values, :score, :non_scoring_dice

  SIDES = [ 1, 2, 3, 4, 5, 6 ]

  def initialize
    @values, @non_scoring_dice, @score = [], 0, 0
  end

  def roll(num = 5)
    # reset values, score, and non_scoring_dice for each roll
    @values, @non_scoring_dice, @score = [], 0, 0
    num.times { @values << SIDES.sample }
    @score = compute_score
    @values
  end

  def compute_score
    points = 0

    (1..6).each do |f|
      c = values.count(f)
      next if c == 0

      points += case
      when f == 1 || f == 5
        score_mul = (f == 1 ? 2 : 1)
        count_mul = (c >= 3 ? c + 7 : c)
        score_mul * count_mul * 50
      when c >= 3
        @non_scoring_dice += (c - 3)
        f * 100
      else
        @non_scoring_dice += c; 0
      end
    end

    points
  end

  def hot_dice?
    @non_scoring_dice == 0
  end
end
