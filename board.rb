class Board
  def initialize(cols, height, num_to_win)
    @num_cols = cols
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
    check_lines(@grid) ||
      check_lines(@grid.transpose) ||
      diagonal_winner
  end

private
  attr_reader :num_cols, :height

  def diagonal_winner
    check_diagonal(true) || check_diagonal(false)
  end

  def check_diagonal(pos)
    #if pos = true => check positive slope diagonal /
    #if pos = false => check negative slope diagonal \
    start_col = pos ? 0 : (num_cols - 1)
    diagonals = []
    start_locs = (0...num_cols).map { |col| [0, col] }
    start_locs += (1...height).map { |row| [row, start_col] }

    start_locs.each do |row, col|
      diagonal = []
      while on_board?(row, col)
        diagonal << @grid[row][col]
        row += 1
        col += pos ? 1 : -1
      end
      diagonals << diagonal
    end

    check_lines(diagonals)
  end

end
