class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def prompt
    col = nil
    until col && valid_input?(col)
      puts "Which column do you want to place the mark in?"
      col = gets.chomp.to_i
    end
    col
  end

  def valid_input?(col) #should this be in game?
    col.is_a?(Integer) && col.between?(0,6)
  end

  def to_s
    mark
  end
end
