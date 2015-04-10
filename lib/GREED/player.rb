class Player
  attr_reader :total_points, :name
  attr_accessor :accum_points

  def initialize(name)
    @name = name
    @accum_points = 0
    @total_points = 0
  end

  def bank_accum_points
    points = @accum_points
    @accum_points = 0
    @total_points += points
  end

  def respond_to_roll
    begin
      print "\n(r)oll or (b)ank > "
      response = gets.chomp.downcase[0]
      raise 'input must be (r)oll or (b)ank ' unless ['r', 'b'].include?(response)
      case response
      when 'r' then :roll
      when 'b' then :bank
      end
    rescue Exception => ex
      puts " Error: #{ex.message}"
      retry
    ensure
      system "clear"
    end
  end

  def reset_openning
    @in = false
  end

  def get_in
    @in = true
  end

  def in?
    @in
  end

  def <=>(other_player)
    total_points <=> other_player.total_points
  end
end
