require_relative 'tile'
require 'colorize'

class Board
  attr_reader :grid, :bombs
  BOMB_COUNT = 10
  SIZE = 8

  def initialize
    @grid = make_grid
    populate_bombs
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def make_grid
    grid = []
    (0..SIZE).each do |row|
      line = []
      (0..SIZE).each do |col|
        line << Tile.new(self, row, col)
      end
      grid << line
    end
    grid
  end

  def populate_bombs
    grid.flatten.sample(BOMB_COUNT).each do |tile|
      tile.bombed = true
    end
  end

  def won?
    @grid.flatten.each do |tile|
      return false unless tile.revealed || tile.flagged
    end
    count_flags == BOMB_COUNT
  end

  def count_flags
    @grid.flatten.count { |tile| tile.flagged }
  end


  def flip(row, col)
    self[row, col].reveal
    return self[row, col]
  end

  def display(bomb = false)
    puts "flags left: #{BOMB_COUNT - count_flags}"
    puts "  #{(0..SIZE).to_a.join("   ")}"
    @grid.each_with_index do |row, idx|
      print "#{idx} "
      puts row.map { |tile| tile.to_s }.join(" | ")
      print "  "
      puts "-" * 34
    end
  end
end
