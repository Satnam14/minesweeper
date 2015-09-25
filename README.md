# Minesweeper

## Introduction

![Screenshot](http://res.cloudinary.com/satnam14/image/upload/c_scale,q_100,w_592/v1443217388/screenshot_cnc05l.png)

## How to download and run

1. Install Ruby. If you already have installed Ruby then skip to step 2
   - [Install Ruby on Mac or Linux](https://www.ruby-lang.org/en/documentation/installation/)
   - [Install Ruby on Windows](http://rubyinstaller.org/)
2. Download this repository (Click "Download as Zip button on the right")
3. Extract the downloaded zip into the directory/folder of your choice
4. Open a terminal
  - If you're on Mac, press CMD + SPACE and type terminal
  - If you're on Windows, press the Windows key and type cmd
5. CD into the directory where you extracted the zip file
  - See this if you're not sure what that means - [Terminal Basics](http://mac.appstorm.net/how-to/utilities-how-to/how-to-use-terminal-the-basics/)
6. Run the game using the command "ruby game.rb"

## How to Play

1. Choose the position you want to play by entering it'd coordinates. E.g. 3,4
2. Choose the type of move (Flag vs. Reveal) using f and r keys respectively
3. Save the game using the y key when prompted
4. Hold down CTRL+C to quit at any time
5. Wikipedia - [Wikipedia](https://en.wikipedia.org/wiki/Minesweeper_(video_game))

## Classes and Object-Oriented Design

- Game
  - Starts the game with a board and places 10 bombs at random positions
  - Processes and validates user input
  - Reveals or Flags positions on the board after user input is validated
  - If user choose to reveal, #reveal method will be called on the tile at the chosen position
    - If it contains a bomb, game over.
    - Otherwise, it will be revealed.
    - If none of its neighbors contains a bomb, then all the adjacent neighbors are also revealed.
    - If any of the neighbors have no adjacent bombs, they too are revealed. Et cetera.
  - If user choose to flag, #flag method will be called on the tile at the chosen position
    - The user may also flag a square as containing a bomb.
    - If a bomb is flagged incorrectly, it is not eligible to be revealed, even if it otherwise would be.
  - Serializes the board and stores it in YAML format if asked to save the game
  - Ends the game if all bombs are flagged or if one of the bombs are triggered
- Board
  - Initializes a grid of SIZExSIZE, depending on the difficulty level chosen
  - Places N bombs on the grid, depending on the difficulty level chosen
  - Holds all the empty positions and bombs in the grid
- Tile
  - Can be a bomb or an empty spot
  - Uses colorize to display
    - bomb as red
    - flag as blue
  - #neighbors methods returns all the neighbors of the tile

## Basics of Minesweeper

The player is initially presented with a grid of undifferentiated squares. Some randomly selected squares, unknown to the player, are designated to contain mines. Typically, the size of the grid and the number of mines are set in advance by the user, either by entering the numbers or selecting from defined skill levels, depending on the implementation.

The game is played by revealing squares of the grid by clicking or otherwise indicating each square. If a square containing a mine is revealed, the player loses the game. If no mine is revealed, a digit is instead displayed in the square, indicating how many adjacent squares contain mines; if no mines are adjacent, the square becomes blank, and all adjacent squares will be recursively revealed. The player uses this information to deduce the contents of other squares, and may either safely reveal each square or mark the square as containing a mine.

## To Do

- [x] All user input validations should belong to Game class
- [x] Tile#neighbors should return all the adjacent tiles
- [x] Represent a bomb using a boolean #bombed rather than using values
- [x] Use colorize to decorate output
- [x] Use YAML to serialize and store the board
- [x] Allow user to load the game using a saved game
- [ ] Allow user to choose difficulty
- [ ] Use io/console to facilitate modern input
- [ ] Facilitate saving a game using a save key rather than asking before each move
