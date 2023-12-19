-- main = putStrLn "Hello, world!"

main :: IO ()
main = do
        (putStrLn "Введите счисло A: ")
        tmp <- getLine
        print $ tmp 

point x y = do
        putStr "\nX = "

