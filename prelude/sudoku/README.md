# Sudoku

This is a Sudoku puzzle generator and interactive solver. Sudokus are solved by
filling in a 9x9 grid with digits 1 through 9 such that each of the 9 columns, 9
rows, and 9 3x3 regions contain each digit exactly once. The puzzles generated
by this program have a unique solution. Additionally, while solving, repeated
digits are highlighted red to allow the solver to catch mistakes early.

* Category: `prelude-10-80`
* Tested with: GHC 9.2.5 on Linux and Windows
* Author: ElderEphemera (Josh Price)

![A sudoku displayed in a terminal](sudoku.png)

## Running

This program can be run with `runghc sudoku.hs`. This should just work on any
platform, though if your terminal does not support VT100 codes the highlighting
will not work (on windows this must be enabled).

## Playing

To use the interactive solver, first enter a seed to start the generating a
Sudoku. You can just mash on the number keys; as long as you enter a valid
integer it will work. Generation usually takes around 15 seconds or less, but
can take a couple minutes, maybe more. Feel free to restart with a different
seed if you're impatient.

To solve the puzzle, use three character commands where the first character
represents a row, the second is the column, and the third is the digit to insert
(or '.' for erasing a digit). For example, entering "641" will put the digit '1'
in row 6 column 4 (rows start from the top, columns from the left).

## Implementation

The implementation keeps state as a grid of characters tagged with whether or
not they are repeated (the type is `[[(Bool, Char)]]`) with blank cells
represented by the '.' character. This same representation is used during
generation as well.

The generator starts with a blank board and a randomized (based on the given
seed) digit priority and starting position. Then the digits are filled in order
by a simple backtracking solver to obtain a completed Sudoku board. Then, cells
are emptied in a random order as long as there continues to be a single valid
way to solve the puzzle (checked using the same solver).
