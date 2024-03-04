import Data.List
import Text.Printf

revJac x11 x12 x21 x22 = (revJac11, revJac12, revJac21, revJac22)
    where   det = x11 * x22 - x12 * x21
            revJac11 = x22 / det
            revJac12 = -x12 / det
            revJac21 = -x21 / det
            revJac22 = x11 / det

jacobian0 x y x0 y0 a b k m =
    let t_x11 = (2 * x - 2 * x0) / (a * a)
        t_x12 = (2 * y - 2 * y0) / (b * b)
        t_x21 = k
        t_x22 = m 
        det = t_x11 * t_x22 - t_x12 * t_x21
    in  if (det /= 0) then
            (t_x11, t_x12, t_x21, t_x22)
        else
            (1, 0, 0, 1)

kostylb denomTest | denomTest == 0  = 1
                  | otherwise       = denomTest

validateDenom a = do 
    if a == 0 then 
        error "Неправильный параметр, происходит деление на ноль"
    else
        True 

validEq k m = do 
    if k == 0 && m == 0 then 
        error "Уравнение задано не верно, невозможные параметры k, m"
    else
       True 

answer x y = do
    putStr "Точка:\nX = " 
    printf "%.3f\n" x
    putStr "Y = " 
    printf "%.3f\n" y


broyden x y x0 y0 a b k m jac11 jac12 jac21 jac22 5000 = do 
    error "Кол-во шагов превышено, точки не найдены"
broyden x y x0 y0 a b k m jac11 jac12 jac21 jac22 cnt = 
    let fn1 = (((x - x0)*(x - x0) / (a * a)) + ((y - y0)*(y - y0) / (b * b))) - 1
        fn2 = ((k * x) + (m * y)) - 1
        xn1 = x - (jac11*fn1 + jac12*fn2)
        xn2 = y - (jac21*fn1 + jac22*fn2)
        nextFn1 = (((xn1 - x0)*(xn1 - x0) / (a * a)) + ((xn2 - y0)*(xn2 - y0) / (b * b))) - 1
        nextFn2 = ((k * xn1) + (m * xn2)) - 1

        deltaXn1 = xn1 - x
        deltaXn2 = xn2 - y
        deltaNextFn1 = nextFn1 - fn1
        deltaNextFn2 = nextFn2 - fn2
         -- check precision
    in  if ((deltaXn1*deltaXn1 + deltaXn2*deltaXn2) < 0.0000001 * 0.0000001) then 
            answer xn1 xn2 
        else
            let fn1 = (((x - x0)*(x - x0) / (a * a)) + ((y - y0)*(y - y0) / (b * b))) - 1
                fn2 = ((k * x) + (m * y)) - 1
                xn1 = x - (jac11*fn1 + jac12*fn2)
                xn2 = y - (jac21*fn1 + jac22*fn2)
                nextFn1 = (((xn1 - x0)*(xn1 - x0) / (a * a)) + ((xn2 - y0)*(xn2 - y0) / (b * b))) - 1
                nextFn2 = ((k * xn1) + (m * xn2)) - 1
                deltaXn1 = xn1 - x
                deltaXn2 = xn2 - y
                deltaNextFn1 = nextFn1 - fn1
                deltaNextFn2 = nextFn2 - fn2
            
                 -- numerator
                mul1 = (jac11*deltaNextFn1 + jac12*deltaNextFn2)
                mul2 = (jac21*deltaNextFn1 + jac22*deltaNextFn2)
                sub1 = deltaXn1 - mul1
                sub2 = deltaXn2 - mul2
            
                 -- denominator
                xToJ1 = deltaXn1*jac11 + deltaXn2*jac21
                xToJ2 = deltaXn1*jac12 + deltaXn2*jac22
                denomTest = xToJ1*deltaNextFn1 + xToJ2*deltaNextFn2
                denom = kostylb denomTest
                                                                 
                 -- all fraction
                div1 = sub1 / denom
                div2 = sub2 / denom
            
                 -- update jacobian
                newJac11 = jac11 + (div1*xToJ1)
                newJac12 = jac12 + (div1*xToJ2)
                newJac21 = jac21 + (div2*xToJ1)
                newJac22 = jac22 + (div2*xToJ2)
                cnt1 = cnt + 1
            in  broyden xn1 xn2 x0 y0 a b k m  newJac11 newJac12 newJac21 newJac22 cnt1

choose x0 y0 a b k 0 = (x1, y1, x2, y2)
                        where   y1 = y0 + b 
                                y2 = y0 - b
                                x1 = x0
                                x2 = x0

choose x0 y0 a b k m = (x1, y1, x2, y2)
                        where   y1 = y0  
                                y2 = y0
                                x1 = x0 - a
                                x2 = x0 + a

startBroyden x y x0 y0 a b k m = do
    let (x11, x12, x21, x22) = jacobian0 x y x0 y0 a b k m
        (revJac11, revJac12, revJac21, revJac22) = revJac x11 x12 x21 x22
    broyden x y x0 y0 a b k m revJac11 revJac12 revJac21 revJac22 0

input = do 
    putStr "Введите x0: "
    x0 <- readLn :: IO Double
    putStr "Введите y0: "
    y0 <- readLn :: IO Double
    putStr "Введите a: "
    a <- readLn :: IO Double
    if validateDenom a then do
        putStr "Введите b: "
    else error ""
    b <- readLn :: IO Double
    if validateDenom b then do
        putStr "Введите k: "
    else error "" 
    k <- readLn :: IO Double
    putStr "Введите m: "
    m <- readLn :: IO Double
    if validEq k m then 
        return (x0, y0, a, b, k, m)
    else 
        error ""

main = do 
    (x0, y0, a, b, k, m) <- input
    let (x1, y1, x2, y2) = choose x0 y0 a b k m
    startBroyden x1 y1 x0 y0 a b k m
    startBroyden x2 y2 x0 y0 a b k m
