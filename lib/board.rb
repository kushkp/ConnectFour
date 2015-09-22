require 'byebug'

class Board
  attr_reader :num_cols, :height, :num_to_win, :grid, :winner
  #grid reader created for unit testing only

  def initialize(cols, height, num_to_win)
    @num_cols = cols
    @height = height
    @num_to_win = num_to_win
    @last_disc = nil
    @winner = nil
    @grid = Array.new(height) { Array.new(cols) {} }
  end

  def drop_disc(disc, col)
    curr_height = col_height(col)
    return false if curr_height == height
    self.grid[height - curr_height - 1][col] = disc
    self.last_disc = [height - curr_height - 1, col]
  end

  def has_space?(col)
    col_height(col) < height
  end

  def on_board?(row, col)
    col.between?(0, num_cols - 1) && row.between?(0, height - 1)
  end

  def over?
    !!winner
  end

  def render
    content = ""
    num_cols.times { |col_num| content << " #{col_num}" }
    content << "\n"

    grid.each do |row|
      content << "|"
      row.each do |pos|
          content << (pos || " ") << "|"
      end
      content << "\n"
    end

    puts content
  end

  def update_winner
    self.winner = check_lines(horizontal_line) ||
      check_lines(vertical_line) ||
      diagonal_winner
  end

private
  attr_writer :grid, :winner
  attr_accessor :last_disc

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
        diagonal << grid[row][col]
        row += 1
        col += pos ? 1 : -1
      end

      diagonals << diagonal
    end

    check_lines(diagonals)
  end

  def check_lines(lines)
    lines.each do |line|
      winner = in_a_row(line)
      return winner unless winner.nil?
    end

    nil
  end

  def col_height(col)
    grid.transpose[col].compact.length
  end

  def diagonal_winner
    check_diagonal(true) || check_diagonal(false)
  end

  def horizontal_line
    create_line(grid, num_cols, true)
  end

  def vertical_line
    create_line(grid.transpose, height, false)
  end

  def create_line(matrix, upper_bound, horizontal)
    row, col = horizontal ? last_disc : last_disc.reverse
    offset = num_to_win
    min = col - offset
    min = 0 if min < 0
    max = col + offset
    max = upper_bound if max > upper_bound

    [matrix[row][min...max]]
  end

  def in_a_row(line)
    return nil if line.compact.length < num_to_win
    (0..(line.length - num_to_win)).each do |idx|
      first_disc = line[idx]
      next if first_disc.nil?
      if line[idx...(idx + num_to_win)].all? { |el| el == first_disc }
        return first_disc
      end
    end

    nil
  end
end
