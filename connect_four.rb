require_relative 'board'
require_relative 'player'
require 'byebug'

class ConnectFour
  def initialize(board_vals = [6,7,4])
    @player1 = Player.new(:x)
    @player2 = Player.new(:o)
    @players = [@player1, @player2]
    @board = Board.new(*board_vals)
  end

  def change_turn
    @players.reverse!
  end

  def play
    until @board.over?
      take_turn
      change_turn
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


#run game
if __FILE__ == $PROGRAM_NAME
  puts "Enter num of columns, height, and number of discs in a row to win or 'd' for default (ie. '6,7,4'): >"
  board_vals = gets.chomp
  if board_vals == "d"
    game = ConnectFour.new()
  else
    board_vals = input.split(',')
    game = ConnectFour.new(board_vals)
  end

  game.play
end
