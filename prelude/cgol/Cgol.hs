main=run(ib 10);dc='⋅';lc='O';ib s=replicate s (replicate s dc);tc b (x,y)=r y
 b (r x(b!!y)(t((b!!y)!!x)));t c=if c==dc then lc else dc;ac b []=b;ac b (x:xs)=
 ac(tc b x)xs;r x l e=(take x l)++(e:(drop (x+1) l));pb b=mapM putStrLn b;ns b=
 ac b(sc b);sc b=[(x,y)|x<-[1..(length b)-2],y<-[1..(length b)-2],sct b(x,y)];
sct b(x,y)=(((b!!y)!!x)==dc && c==3)||(((b!!y)!!x)==lc&&c/=2 && c/=3)where{c=cln
 b(x,y)};cln b(x,y)=sum[1|x2<-[-1..1],y2<-[-1..1],x2/=0||y2/=0,((b!!(y+y2))!!(x+
 x2))==lc];u b ('r':rest)=ib(read rest);u b "n"=ns b;u b('t':rest)=tc b(pos!!0,
 pos!!1)where pos=(map read (words rest));u b _=b;
run b=do pb b;putStr "Action ((r)eset 'Int', (n)ext state, (t)oggle cell 'Int \
\Int'): ";i<-getLine;run(u b i)
-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/cgol (Rens van Hienen)

This is an implementation of Conway's game of life. Made for the Haskell tiny
game jame of February 2023.

The following actions are possible:
-Reset the board with a new given size by entering 'r' followed by a valid Int
 seperated by white space. The grid is always square with an initial size of 10.
-Go to the next state by entering 'n'.
-Toggle an individual cell by entering 't' followed by two valid Int's
 seperated by white space. Use this to set up the initial state. Keep in mind
 that indexing is zero based. x axis is entered first and y axid second.

The cells are stored in a [String] with '⋅' being a dead cell and 'O' a living
cell. The cells on the border are not changed by processing the next state.
This allows the user to decide whether the edges should count as living or
dead. But also relieves me of having to check if a cell is on an edge. Currently
there are no checks for invalid input, so this will crash the program.

unminified code:

type Board = [String]

deadCell = '⋅'
livingCell = 'O'

initBoard :: Int -> Board
initBoard s = replicate s (replicate s deadCell)

toggleCell :: Board -> (Int,Int) -> Board
toggleCell b (x,y) = replace y b (replace x (b !! y) (toggle ((b !! y) !! x)))

toggle :: Char -> Char
toggle c = if c == deadCell then livingCell else deadCell

replace :: Int -> [a] -> a -> [a]
replace x l e = (take (x) l) ++ (e : (drop (x+1) l))

printBoard :: Board -> IO [()]
printBoard b = mapM putStrLn b

nextState :: Board -> Board
nextState b = applyChanges b (stateChanges b)

stateChanges :: Board -> [(Int,Int)]
stateChanges b = [(x,y) | x <- [1..((length b)-2)], y <- [1..((length b)-2)], shouldCellToggle b (x,y)]

shouldCellToggle :: Board -> (Int,Int) -> Bool
shouldCellToggle b (x,y) = (((b!!y)!!x) == deadCell && c == 3) || (((b!!y)!!x) == livingCell && c /= 2 && c /= 3)
    where c = countLivingNeighBours b (x,y)

countLivingNeighBours :: Board -> (Int,Int) -> Int
countLivingNeighBours b (x,y) = sum [1 | x2 <- [(-1)..1], y2 <- [(-1)..1], x2 /= 0 || y2 /= 0, ((b!!(y+y2))!!(x+x2)) == livingCell]

applyChanges :: Board -> [(Int,Int)] -> Board
applyChanges b [] = b
applyChanges b (x:xs) = applyChanges (toggleCell b x) xs

update :: Board -> String -> Board
update b ('r' : rest) = initBoard (read rest)
update b "n" = nextState b
update b ('t' : rest) = toggleCell b (pos!!0, pos!!1) where pos = (map read (words rest))
update b _ = b

run :: Board -> IO()
run b = do  printBoard b
            putStr "Action ((r)eset 'Int', (n)ext state, (t)oggle cell 'Int Int'): "
            input <- getLine
            run (update b input)

main = run (initBoard 10)

-}
