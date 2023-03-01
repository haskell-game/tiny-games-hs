import Import;

printSec :: Double -> IO ()
printSec sec = do {
    when (sec>= -0.01) $ do {
        -- \ESC[2K clears the line
        -- \ESC[A  moves cursor up
        -- Therefore the ansii expression says:
        --   clear the line in which the cursor is, and the one above
        -- This create the cool countdown effect and erase the user input.
        printf "\r\ESC[2K\ESC[A\ESC[2K%.2f secs\n" sec;
        threadDelay 20000;
        printSec (sec-0.02);
    }
  }

check :: [Char] -> Int
check = length . takeWhile (== True) . zipWith (==) ['a'..'z']

-- We need to stream the user input in a IORef as sort of a channel
-- code thanks to @li-yao-xia in stackoverflow. Couldn't have done by myself
-- https://stackoverflow.com/questions/75408832/haskell-how-to-make-my-program-to-terminate
main :: IO ()
main = do 
  s <- getArgs
  hSetBuffering stdin NoBuffering 
  buf <- newIORef [] 
  putStrLn "start\n" 
  threadId <- forkIO $ forever $ do 
    c <- getChar
    atomicModifyIORef' buf (\cs -> (c : cs, ()))
  printSec $ 
    case s of 
      ["-x"] ->3
      ["-h"] ->5
      ["-e"] ->10
      _     ->7
  putStrLn "\nend\n"
  killThread threadId
  a <- reverse <$> readIORef buf
  printf "you typed %s\n" a
  printf "your score is: %.2f%%" (100*fromIntegral(check a) / 26 :: Double)
  