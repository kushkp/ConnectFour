class Board
  def initialize(cols, height, num_to_win)
    @cols = cols
    @height = height
    @grid = Array.new(cols) { Array.new(height) { :O } }
  end

  def drop_disc(disc, col)
    curr_height = col_height(col)
    return false if curr_height == height
    row_idx = row - curr_height - 1
    @grid[row_idx][col] = disc
  end

  def over?
    !!winner
  end

  def winner
    
  end

private
  attr_reader :cols, :height
end
