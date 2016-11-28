# Haskell Maze 1

_Programming assignment for the course [Functional Programming](https://www.vub.ac.be/en/study/fiches/54625/functional-programming) taught at [VUB SOFT Department](http://soft.vub.ac.be/soft)_

The goal of this programming assignment is to create a terminal-based application for escaping mazes. Your application should load a maze from a standard text file and print in the terminal a wandering that links the starting position `*` to an escape `@`. If your application could not find such a wandering it should still display its wandering.

Below is a more formal description of a maze:

  1. A maze is encoded as a list of lists of characters – i.e.: `[[Char]]` – which are each denoting a cell.
  2. The walls of the maze are denoted by an `X`; the empty cells are denoted by a blank space.
  3. You can assume that walls are always completely enclosing the maze so that it is not possible to step out of its boundaries.
  4. You can assume that walls are all connected; such mazes are commonly referred as _perfect_ mazes.
  5. The start cell is denoted by an `*` and is always located at the second line, second column of the maze.
  6. The escapes are denoted by an `@`; they can be located anywhere next to a wall.
  7. A maze without escape is possible.
 
Provided that the maze fulfills the requirements given above, your application should behave as follow:

  1. Your application should wander in cross-like motions – i.e.: diagonal moves are not allowed.
  2. The wandering of your implementation should never overlap with a wall.
  3. If a wandering linking the entrance to an escape exists, your application should find it.
  4. Your application should always terminate and show its wandering.

Here is an example maze and its wandering:

    XXXXXXXXXXXXXX
    X*XXX XXXXXXXX
    X            X
    X XX XXXXX X X
    XXXX XX    X X
    X@    XXXXXXXX
    XXXXXXXXXXXXXX

    XXXXXXXXXXXXXX
    X*XXX XXXXXXXX
    X............X
    X.XX.XXXXX.X.X
    XXXX.XX....X.X
    X@... XXXXXXXX
    XXXXXXXXXXXXXX
