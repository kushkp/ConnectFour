class Board
  def initialize(cols, height, num_to_win)
    @num_cols = cols
    @height = height
    @num_to_win = num_to_win
    @grid = Array.new(cols) { Array.new(height) { :. } }
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

  def render
    content = ""
    @grid.each do |row|
      content << "|"
      row.each do |pos|
        content << (pos || " ") << "|"
      end
      content << "\n"
    end

    puts content
  end

  def winner
    check_lines(@grid) ||
      check_lines(@grid.transpose) ||
      diagonal_winner
  end

private
  attr_reader :num_cols, :height, :num_to_win

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

  def check_lines(lines)
    lines.each do |line|
      winner = in_a_row(line)
      return winner unless winner.nil?
    end
    nil
  end

  def in_a_row(line)
    return nil if line.length < num_to_win
    (0..(line.length - num_to_win)).each do |idx|
      first_disc = line[idx]
      next if first_disc.nil?
      if line[idx...(idx + num_to_win)].all? { |el| el == first_disc }
        return first_disc #change to player
      end
    end
    nil
  end

  def column_height(col)
    @grid.transpose[col].compact.length
  end
end
