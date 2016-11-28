import qualified System.Environment
import Data.List (delete, elem)

main :: IO ()
main = do [path] <- System.Environment.getArgs
          maze <- readFile path
          putStr $ unlines $ escape $ lines maze

-- Get the current position
-- Get a list of all free positions + the goal position
-- Keep a list of all visited positions
-- Start loop:
-- Get all free neighbours of the current position
-- If the goal is in this list: end
-- If there are free neighbours:
--     Move to one of the neighbours, remove it from the list of free positions
--     and add it to the list of visited positions. Loop.
-- If there are no free neighbours:
--     If if all free places are visited: end
--     Else: backtrack
-- Backtracking happens by going over the list of visited positions
-- in the opposite direction (i.e. literally walking back). For each
-- position, check if this position has free neighbours left.
-- If not: continue backtracking
-- If yes: go to this position

escape :: [[Char]] -> [[Char]]
escape maze =
    let start = (1,1)
        goal = elemIndexes maze "@"
        free = elemIndexes maze " " ++ goal
        visited = escapeLoop maze start goal free []
    in markVisited maze visited

elemIndexes :: [[Char]] -> [Char] -> [(Int,Int)]
elemIndexes maze item =
    let rows = length maze
        cols = length $ head maze
    in [ (r,c) | r <- [0..rows-1], c <- [0..cols-1], getItem maze (r,c) == item]

getItem :: [[Char]] -> (Int,Int) -> [Char]
getItem maze (r,c) = [maze !! r !! c]

escapeLoop :: [[Char]] -> (Int, Int) -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> [(Int,Int)]
escapeLoop maze current goal free visited
    | goal /= [] && elem (head goal) possible_next = visited
    | free == [] = visited
    | possible_next /= [] = let next = head $ possible_next
                            in next:visited `seq` escapeLoop maze next goal (delete next free) (next:visited)
    | otherwise = let next = backtrack maze free visited
                  in escapeLoop maze next goal free visited
    where possible_next = freeNeighbours maze current free

freeNeighbours :: [[Char]] -> (Int, Int) -> [(Int, Int)] -> [(Int, Int)]
freeNeighbours maze current free = filter (\x -> isNeighbour current x) free

isNeighbour :: (Int, Int) -> (Int, Int) -> Bool
isNeighbour (r1,c1) (r2,c2) = (r1 == r2 && abs (c1 - c2) == 1) || (c1 == c2 && abs (r1 - r2) == 1)

backtrack :: [[Char]] -> [(Int,Int)] -> [(Int,Int)] -> (Int,Int)
backtrack maze free visited
    | neighbours /= [] = possible_revisit
    | otherwise = backtrack maze free (tail visited)
    where possible_revisit = head visited
          neighbours = freeNeighbours maze possible_revisit free

markVisited :: [[Char]] -> [(Int, Int)] -> [[Char]]
markVisited maze visited =
    let rows = length maze
        cols = length $ head maze
    in map (\r -> map (\c -> head $ getSymbol maze (r,c) visited) [0..cols-1]) [0..rows-1]

getSymbol :: [[Char]] -> (Int,Int) -> [(Int,Int)] -> [Char]
getSymbol maze pos visited
    | elem pos visited && item /= "@" = "."
    | otherwise = item
    where item = getItem maze pos
