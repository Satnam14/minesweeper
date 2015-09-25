require_relative 'lib/board'
require 'yaml'

class Game
  attr_accessor :board

  def self.start_game
    puts "Welcome to minesweeper!"
    puts "Enter N for new game, or S to load a saved game file"
    input = gets.chomp.downcase
    valid = ["n", "s"]
    until valid.include?(input)
      puts "Invalid input. Please enter either N or S"
      input = gets.chomp.downcase
    end
    if input == "n"
      Game.new
    else
      puts "Please choose a file number"
      files = Dir["**/*.yml"]
      files.each_with_index do |file, index|
        puts "#{index}. #{file}"
      end
      input = gets.chomp.to_i
      Game.new(files[input])
    end
  end

  def initialize(filename = nil)
    if filename.nil?
      @board = Board.new
    else
      @board = YAML::load_file(filename)
    end
    play
  end

  def load_file(filename)
    YAML::load(filename)
  end

  def play
    board.display
    until board.won?
      coords = get_coords
      intentions = flip_or_flag

      if intentions == :f
        board[*coords].flag
      else
        tile = board.flip(*coords)
        if tile.bombed
          puts "BOOOOOM!!!!!"
          board.display(true)
          break
        end
      end
      board.display
      save_game
    end
    puts "Congrats" if board.won?
  end

  def get_coords
    puts "Where would you like to move?"
    coords = gets.chomp.split(",").map! {|coord| coord.to_i}
    p coords
    if coords.all? { |coord| coord.between?(0, 8) }
      return coords
    else
      puts "Invalid entry- please enter two numbers between 0 and 8. e.g. '2,3'"
      get_coords
    end
  end

  def flip_or_flag
    puts "Reveal or flag ('r' or 'f')?"
    answer = gets.chomp.downcase
    if ['r', 'f'].include?(answer)
      return answer.to_sym
    else
      puts "Invalid choice!"
      flip_or_flag
    end
  end

  def save_game
    puts "Save game? (y/n)"
    input = gets.chomp.downcase
    if input == "y"
      puts "Please name your file."
      file_name = gets.chomp
      state = @board.to_yaml
      File.open("saved_games/#{file_name}.yml", "w") do |f|
        f.puts(state)
      end
      puts "Do you want to quit? (y/n)"
      answer = gets.chomp.downcase
      abort if answer == "y"
    end
  end

end

Game.start_game
