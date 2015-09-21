require_relative 'board'
require_relative 'player'
require 'byebug'

class ConnectFour
  def initialize(board_vals = [6,7,4])
    @cols = board_vals.first
    @player1 = Player.new(:x)
    @player2 = Player.new(:o)
    @players = [@player1, @player2]
    @board = Board.new(*board_vals)
  end

  def current_player
    players.first
  end

  def play
    until board.over?
      take_turn
      change_turn
    end
    board.render
    puts "#{players.last} wins!"
  end

private
  attr_reader :cols, :players, :board

  def change_turn
    players.reverse!
  end

  def print_error_msg
    puts "Invalid column. Please choose an empty column on the board."
  end

  def prompt
    puts "Which column do you want to place the mark in?"
    col = gets.chomp.to_i
  end

  def take_turn
    board.render
    col = prompt
    until col && valid_input?(col)
      print_error_msg
      col = prompt
    end

    board.drop_disc(current_player.mark, col)
  end

  def valid_input?(col)
    col.is_a?(Integer) &&
      col.between?(0, cols - 1) &&
      board.has_space?(col)
  end
end

#run game
if __FILE__ == $PROGRAM_NAME
  puts "Enter num of columns, height, and number of discs in a row to win or 'd' for default (ie. '6,7,4'): >"
  board_vals = gets.chomp
  if board_vals == "d"
    game = ConnectFour.new()
  else
    board_vals = board_vals.split(',').map(&:to_i)
    game = ConnectFour.new(board_vals)
  end

  game.play
end
