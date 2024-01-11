import Data.List

removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (/= x) xs)

insertPoints = do 
    putStrLn "!!! Ввод опорных точек !!! "
    putStr " Введите кол-во точек : "
    cnt <- readLn :: IO Int
    if cnt < 2 then 
        error "Неправильное число точек"
    else do
        result <- points cnt cnt
        putStr " Введенные точки : "
        print $ sort $ result
        return $ (sort $ result, cnt)

points len 0 = do return []
points len cnt  | cnt < 0   = error " Кол-во не может быть отрицательным"
            | otherwise = do
    putStr " Точка "  
    print (len - cnt + 1)
    (x,y) <- point
    temp <- points len (cnt - 1)
    if null temp then
        return $ [(x,y)]
    else
        return $ [(x,y)] ++ temp

point = do 
    putStr "  X = "
    x <- readLn :: IO Double
    putStr "  Y = "
    y <- readLn :: IO Double
    return (x, y)

order = do 
    putStrLn "!!! Порядок сплайна !!!"
    putStr " Введите число от 1 до 10 : "
    someNum <- readLn :: IO Integer 
    if someNum > 0 && someNum < 11 then 
        return someNum
    else 
        error "Неправильно введен порядок сплайна"

precision = do  
    putStrLn "!!! Шаг итогового графика !!!"
    putStr " Введите положительное число : "
    someNum <- readLn :: IO Double 
    if someNum > 0 then 
        return someNum
    else 
        error "Шаг должет быть положительным"

formatList [] = ""
formatList ((x, y):xs) = show x ++ ";" ++ show y ++ "\n" ++ formatList xs

main = do 
    putStrLn "  --- Построение сплайна ---"
    order <- order
    precision <- precision
    (list, cnt) <- insertPoints
    let i = cnt
    let equation = equations list (cnt - 1) order 1
    -- let temp = interpolation equation precision list cnt order
    print equation
    print $ solve equation
    -- print (list, cnt)
    -- print order
    -- print precision
    writeFile "output.csv" $ formatList list


interpolation equation precision list cnt order i   | i > last_x = []
                                                    | otherwise = 
    if length list == 1 then let

        in
    else let 

        in

    interpolation equation precision list cnt order (i + precision)
    where   (last_x,_) = last list
            (x0,y0) = list !! 0
            (x1,y1) = list !! 1

    
    



-- Коэфициенты полинома
polinom 1 start (x, y) = [(x - start), 1, y]
polinom order start (x, y) = [(x - start) ^ order] ++ polinom (order - 1) start (x, y)
    
-- Коэфициенты первой производной полинома
-- polinom' :: Int -> Double -> Double -> [Double]
polinom' 1 start x = [1, 0, 0]
polinom' order start x = [((x - start) ^ (order - 1)) * fromIntegral order] ++ polinom' (order - 1) start x

-- Коэфициенты второй производной полинома
polinom'' 1 start x = [0, 0, 0]
polinom'' 2 start x = [2] ++ polinom'' 1 start x
polinom'' order start x = [fromIntegral (order * (order - 1)) * ((x - start) ^ (order - 2))] ++ polinom'' (order - 1) start x 

-- extendCoef :: [Double] -> Integer -> Integer -> Integer -> [Double]
extendCoef list interval order i = let
    a1 = take (((fromIntegral order) + 1) * i) (repeat 0.0)
    a2 = take (((fromIntegral order) + 1) * (interval - i - 1)) (repeat 0.0)
    in  a1 ++ init list ++ a2 ++ [last list]

derivitiveEquals :: [Double] -> [Double] -> [Double]
derivitiveEquals = zipWith (\a b -> a - b) 

equations list cnt order i  | cnt == i = 
    [extendCoef (polinom order x0 (x0, y0)) cnt order (i - 1)] ++
    [extendCoef (polinom order x0 (x1, y1)) cnt order (i - 1)] ++
    [extendCoef (polinom'' order x0 x1) cnt order (i - 1)] ++
    [extendCoef (polinom'' order start_x start_x) cnt order 0]
    -- [polinom order x0 (x0, y0)] ++
    -- [polinom order x0 (x1, y1)] ++
    -- [polinom'' order x1 x1] ++
    -- [polinom'' order start_x start_x]
                            | otherwise = let
    pol0 = extendCoef (polinom order x0 (x0, y0)) cnt order (i - 1)
    pol1 = extendCoef (polinom order x0 (x1, y1)) cnt order (i - 1)
    pol'0 = extendCoef (polinom' order x0 x1) cnt order (i - 1)
    pol'1 = extendCoef (polinom' order x1 x1) cnt order i
    pol''0 = extendCoef (polinom'' order x0 x1) cnt order (i - 1)
    pol''1 = extendCoef (polinom'' order x1 x1) cnt order i
    -- pol0 = polinom order x0 (x0, y0)
    -- pol1 = polinom order x0 (x1, y1)
    -- pol'0 = polinom' order x0 x1
    -- pol'1 = polinom' order x1 x1
    -- pol''0 = polinom'' order x0 x1
    -- pol''1 = polinom'' order x1 x1
    in  [pol0] ++ [pol1]++
        -- [pol'0] ++ [pol'1]++ 
        -- [pol''0] ++ [pol''1] ++ 
        [derivitiveEquals pol'0 pol'1]++ 
        [derivitiveEquals pol''0 pol''1] ++ 
        equations list cnt order (i + 1)
    where 
        (x0, y0) = list !! (i - 1)
        (x1, y1) = list !! i 
        (start_x, start_y) = list !! 0



-- Метод Гауса решения слау
gaussianReduce matrix = fixlastrow $ foldl reduceRow matrix [0..length matrix-1] where
    -- swap меняет местами строки
    swap xs a b
        | a > b = swap xs b a
        | a == b = xs
        | a < b = let
        (p1,p2) = splitAt a xs
        (p3,p4) = splitAt (b-a-1) (tail p2)
        in p1 ++ [xs!!b] ++ p3 ++ [xs!!a] ++ (tail p4)

    reduceRow matrix1 r = let
        --first non-zero element on or below (r,r).
        -- if (filter (\x -> matrix1 !! x !! r /= 0) [r..length matrix1-1]) then
        firstnonzero = head $ filter (\x -> matrix1 !! x !! r /= 0) [r..length matrix1-1]

        --matrix with row swapped (if needed)
        matrix2 = swap matrix1 r firstnonzero

        --row we're working with
        row = matrix2 !! r

        --make it have 1 as the leading coefficient
        row1 = map (\x -> x / (row !! r)) row

        --subtract nr from row1 while multiplying
        subrow nr = let k = nr!!r in zipWith (\a b -> k*a - b) row1 nr

        --apply subrow to all rows below
        nextrows = map subrow $ drop (r+1) matrix2

        in  if (not $ null $ filter (\x -> matrix1 !! x !! r /= 0) [r..length matrix1-1]) then
                --concat the lists and repeat
                take r matrix2 ++ [row1] ++ nextrows
            else
                error " Система уравнений не решаемая"

    fixlastrow matrix' = let
        a = init matrix'; row = last matrix'; z = last row; nz = last (init row)
        in a ++ [init (init row) ++ [1, z / nz]]





--Solve a matrix (must already be in REF form) by back substitution.
substitute matrix = foldr next [last (last matrix)] (init matrix) where
    next row found = let
        subpart = init $ drop (length matrix - length found) row
        solution = last row - sum (zipWith (*) found subpart)
        in solution : found

solve = substitute . gaussianReduce

