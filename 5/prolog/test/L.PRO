%trace
predicates
    input(real,real,real,real,real)
    validEq(real, real)
    validateA(real)
    jacobian0(real,real, real,real,real,real,real, real,real,real,real)
    answer(real, real)
    goodBroyden(real, real, real,real,real,real,real, real,real,real,real, integer)
    startBroyden(real, real, real,real,real,real,real)
    inputPoint(real, real)
    revJac(real,real,real,real, real,real,real,real)
    kostylb(real,real)
    choose(real,real,real,real,real, real,real,real,real)
    process(integer)

clauses
    goodBroyden(_,_, _,_,_,_,_, _,_,_,_, Cnt) :-
        Cnt = 1000, clearwindow(), 
        write("Number of steps exceeded"), nl,
        write("No points found"), nl,
        write("X, Y = Infinity"), nl,
        write("Press any button..."), readchar(_), exit.

    goodBroyden(X,Y, X0,Y0,A,M,R, Jac11,Jac12,Jac21,Jac22, Cnt) :-
         %calculating new x, f(x), delta x, delta f(x)
        Fn1 = (((X - X0)*(X - X0) / (A * A)) + ((Y - Y0)*(Y - Y0))) - 1,
        Fn2 = ((M * X) + (R * Y)) - 1,
        Xn1 = X - (Jac11*Fn1 + Jac12*Fn2),
        Xn2 = Y - (Jac21*Fn1 + Jac22*Fn2),
        NextFn1 = (((Xn1 - X0)*(Xn1 - X0) / (A * A)) + ((Xn2 - Y0)*(Xn2 - Y0))) - 1,
        NextFn2 = ((M * Xn1) + (R * Xn2)) - 1,

        DeltaXn1 = Xn1 - X, DeltaXn2 = Xn2 - Y,
        DeltaNextFn1 = NextFn1 - Fn1, DeltaNextFn2 = NextFn2 - Fn2,
         %check precision
        DeltaXn1*DeltaXn1 + DeltaXn2*DeltaXn2 < 0.0000001 * 0.0000001, answer(Xn1,Xn2);

        Fn1 = (((X - X0)*(X - X0) / (A * A)) + ((Y - Y0)*(Y - Y0))) - 1,
        Fn2 = ((M * X) + (R * Y)) - 1,
        Xn1 = X - (Jac11*Fn1 + Jac12*Fn2),
        Xn2 = Y - (Jac21*Fn1 + Jac22*Fn2),
        NextFn1 = (((Xn1 - X0)*(Xn1 - X0) / (A * A)) + ((Xn2 - Y0)*(Xn2 - Y0))) - 1,
        NextFn2 = ((M * Xn1) + (R * Xn2)) - 1,
        DeltaXn1 = Xn1 - X, DeltaXn2 = Xn2 - Y,
        DeltaNextFn1 = NextFn1 - Fn1, DeltaNextFn2 = NextFn2 - Fn2,

         %numerator
        MUL1 = (Jac11*DeltaNextFn1 + Jac12*DeltaNextFn2),
        MUL2 = (Jac21*DeltaNextFn1 + Jac22*DeltaNextFn2),
        SUB1 = DeltaXn1 - MUL1,
        SUB2 = DeltaXn2 - MUL2,

         %denominator
        XtoJ1 = DeltaXn1*Jac11 + DeltaXn2*Jac21,
        XtoJ2 = DeltaXn1*Jac12 + DeltaXn2*Jac22,
        DenomTest = XtoJ1*DeltaNextFn1 + XtoJ2*DeltaNextFn2, 
        kostylb(DenomTest, Denom),

         %all fraction
        Div1 = SUB1 / Denom, Div2 = SUB2 / Denom,

         %update jacobian
        NewJac11 = Jac11 + (Div1*XtoJ1), NewJac12 = Jac12 + (Div1*XtoJ2), 
        NewJac21 = Jac21 + (Div2*XtoJ1), NewJac22 = Jac22 + (Div2*XtoJ2), 
        Cnt1 = Cnt + 1,
        goodBroyden(Xn1, Xn2, X0,Y0,A,M,R, NewJac11,NewJac12,NewJac21,NewJac22, Cnt1).

    kostylb(DenomTest, Denom) :- 
        DenomTest = 0, Denom = 1;
        Denom = DenomTest.

    input(X0,Y0,A,M,R) :- 
        write("Input x0: "), readreal(X0), 
        write("Input y0: "), readreal(Y0), 
        write("Input a: "),  readreal(A),  validateA(A),
        write("Input m: "),  readreal(M), 
        write("Input r: "),  readreal(R), validEq(M,R).

     %check second equation
    validEq(M,R) :-
        M = 0, R = 0, clearwindow,
        write("The equation is set incorrectly"), nl,
        write("Wrong parameters m,r"), nl,
        write("Zero not equal to One"), nl,
        write("Press any button..."), readchar(_),exit;
        true.

    validateA(V) :- 
        V = 0, write("Error! Wrong parameter a!"), nl,
        write("Press any button..."), readchar(_),exit;
        V <> 0.

     %calculate jacobian once for better guesses
    jacobian0(X,Y, X0,Y0,A,M,R, X11,X12,X21,X22) :-
        X11 = (2 * X - 2 * X0) / (A * A), X12 = 2 * Y - 2 * Y0,               
        X21 = M, X22 = R,                            
        DET = X11 * X22 - X12 * X21, DET <>0;
         %some magic trick
        X11 = 1, X12 = 0, X21 = 0, X22 = 1.

    answer(X, Y) :-
        writef("X = %0.3f", X), nl,
        writef("Y = %0.3f", Y), nl, nl.

    startBroyden(X,Y, X0,Y0,A,M,R) :-
        jacobian0(X,Y,X0,Y0,A,M,R, X11,X12,X21,X22),
        revJac(X11,X12,X21,X22, RevJac11,RevJac12,RevJac21,RevJac22),
        goodBroyden(X,Y,X0,Y0,A,M,R, RevJac11,RevJac12,RevJac21,RevJac22, 0).

    revJac(X11,X12,X21,X22, RevJac11,RevJac12,RevJac21,RevJac22) :- 
        DET = X11 * X22 - X12 * X21, 
        RevJac11 = X22 / DET, RevJac21 = -X21 / DET,
        RevJac12 = -X12 / DET, RevJac22 = X11 / DET.

    inputPoint(X,Y) :-
        write("Input X: "), readreal(X),
        write("Input Y: "), readreal(Y).

    choose(X0,Y0,A,M,R, X1,Y1, X2,Y2) :-
        R = 0,
        Y1 = Y0 + 1, Y2 = Y0 - 1,
        X1 = X0, X2 = X0;
        
        X1 = X0 - A, X2 = X0 + A, 
        Y1 = Y0, Y2 = Y0.

    process(1) :-
        clearwindow, input(X0,Y0,A,M,R),
        choose(X0,Y0,A,M,R, X1,Y1, X2,Y2),
        write("Answer:"), nl,
        startBroyden(X1,Y1,X0,Y0,A,M,R),
        startBroyden(X2,Y2,X0,Y0,A,M,R),
        write("Press any button..."), readchar(_).

    process(2) :-
        clearwindow(),
        input(X0,Y0,A,M,R), clearwindow(),
        inputPoint(X,Y), 
        write("Custom start point : ("), 
        write(X), write(","), write(Y), write(")"),nl,
        write("Answer:"), nl,
        startBroyden(X,Y, X0,Y0,A,M,R),
        write("Press any button..."), readchar(_).

    process(3) :-
        clearwindow(),
        input(X0,Y0,A,M,R), clearwindow(),
        inputPoint(X1,Y1), 
        inputPoint(X2,Y2), 
        write("Custom start point 1 : ("), 
        write(X1), write(","), write(Y1), write(")"),nl,
        write("Custom start point 2 : ("), 
        write(X2), write(","), write(Y2), write(")"),nl,
        write("Answer:"), nl,
        startBroyden(X1,Y1, X0,Y0,A,M,R),
        startBroyden(X2,Y2, X0,Y0,A,M,R),
        write("Press any button..."), readchar(_).

goal
      %default
    process(1).
      %one custom point
    %process(2).
      %two custom points
    %process(3).
