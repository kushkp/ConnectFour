class ConnectFour
  def initialize
    @players = ['x', 'o']
    @board =
  end

  def play
    until @board.over?
      take_turn
      @players.reverse!
    end
    @board.render
    puts "#{@players.last} wins!"
  end

  def take_turn
    @board.render
    puts "Enter Column: >"
    col = gets.to_i
    unless @board.drop_disc(@players.first, col)
      puts "Error: that column is already full!"
      take_turn
    end
  end
end
