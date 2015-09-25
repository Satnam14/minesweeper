class Tile
  attr_accessor :flagged, :revealed, :board, :bombed

  NEIGHBORS_OFFSETS = [
    [-1, -1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1]
  ]

  def initialize(board, row, col)
    @revealed = false
    @bombed = false
    @board = board
    @pos = [row, col]
  end

  def reveal
    return if revealed
    @revealed = true
    if neighbor_bomb_count.zero?
      # return @value if @value > 0
      # return @value if @value == -1
      self.neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.revealed
      end
    end
  end

  def to_s
    # if se.value == -1 && bomb == true
    if revealed
      if bombed
        "*".colorize(:red)
      else
        neighbor_bomb_count
      end
    elsif flagged
      "f".colorize(:light_blue)
    else
      " "
    end
  end

  def neighbor_bomb_count
    neighbors.count { |tile| tile.bombed }
  end

  def neighbors
    result = []
    NEIGHBORS_OFFSETS.each do |position|
      coords = [(position[0] + @pos[0]), (position[1] + @pos[1])]
      result << @board[*coords] if coords.all? { |coord| coord.between?(0, 8) }
    end
    result
  end

  def flag
    @flagged = true
  end

end
