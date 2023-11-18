%trace
domains
    x = real
    z = integer

database
    x0(real)
    y0(real)
    a(real)
    m(real)
    r(real)
    jac11(real)
    jac12(real)
    jac21(real)
    jac22(real)
    
predicates
    F1(real, real, real)
    F2(real, real, real)
    input()
    validEq()
    validate(real, string)
    clear_database()
    clear_jac() 
    jacobian0(real,real)
    answer(real, real)
    reverseMatrix(real,real,real,real, real,real,real,real) 
    checkPrecision(real, real, real, real)
    broyden(real, real, integer)
    anotherBroyden(real, real, integer)
    startBroyden(real, real)
    inputPoint(real, real)
    test(integer, real,real,real,real,real,real,real,real,real,real,real,real)
    start()

    %defaultPoints(real, real)
    

clauses
broyden(_,_, Cnt) :-
    Cnt = 46, clearwindow(), 
    write("Number of steps exceeded: Stack overflow"), nl,
    write("No points found"), nl,
    write("X, Y = Infinity"), nl,!.

broyden(X,Y, Cnt) :-
    jac11(Jac11), jac12(Jac12), jac21(Jac21), jac22(Jac22),
    F1(X,Y, Fn1), F2(X,Y, Fn2),
    reverseMatrix(Jac11,Jac12,Jac21,Jac22, RevJac11,RevJac12,RevJac21,RevJac22),
    Xn1 = X - (RevJac11*Fn1 + RevJac12*Fn2),
    Xn2 = Y - (RevJac21*Fn1 + RevJac22*Fn2),
    F1(Xn1, Xn2, NextFn1), F2(Xn1, Xn2, NextFn2), 
    DeltaXn1 = Xn1 - X, DeltaXn2 = Xn2 - Y,
    DeltaNextFn1 = NextFn1 - Fn1, DeltaNextFn2 = NextFn2 - Fn2,
      test(Cnt, Fn1, Fn2, Xn1, Xn2, X, Y, RevJac11, RevJac12, RevJac21, RevJac22, DeltaXn1, DeltaXn2),
    checkPrecision(DeltaXn1, DeltaXn2 ,Xn1, Xn2),

    MUL1 = (Jac11*DeltaXn1 + Jac12*DeltaXn2),
    MUL2 = (Jac21*DeltaXn1 + Jac22*DeltaXn2),
    SUB1 = DeltaNextFn1 - MUL1,
    SUB2 = DeltaNextFn2 - MUL2,
    NormVec = DeltaXn1*DeltaXn1 + DeltaXn2*DeltaXn2,
    Div1 = SUB1 / NormVec, 
    Div2 = SUB2 / NormVec,
    MulTransponse11 = Div1 * DeltaXn1,
    MulTransponse12 = Div1 * DeltaXn2,
    MulTransponse21 = Div2 * DeltaXn1,
    MulTransponse22 = Div2 * DeltaXn2,
    clear_jac(),
    NewJac11 = Jac11 + MulTransponse11, assert(jac11(NewJac11)),
    NewJac12 = Jac12 + MulTransponse12, assert(jac12(NewJac12)),
    NewJac21 = Jac21 + MulTransponse21, assert(jac21(NewJac21)),
    NewJac22 = Jac22 + MulTransponse22, assert(jac22(NewJac22)),
    Cnt1 = Cnt + 1,
    broyden(Xn1, Xn2, Cnt1).

/*
defaultPoints(X, Y) :- 
    X = , Y = 
*/

    clear_jac() :-
        retract(jac11(_)),
        retract(jac12(_)),
        retract(jac21(_)),
        retract(jac22(_)),
        fail.
    clear_jac :- !.

    clear_database:-
        retract(x0(_)),
        retract(y0(_)),
        retract(a(_)),
        retract(m(_)),
        retract(r(_)),
        fail.
    clear_database:-!.

    F1(X, Y, ANS) :-
        x0(X0), y0(Y0), a(A),
        ANS = (((X - X0)*(X - X0) / (A * A)) + ((Y - Y0)*(Y - Y0))) - 1.
    F2(X, Y, ANS) :-
        m(M), r(R),
        ANS = ((M * X) + (R * Y)) - 1.

    input() :- 
        write("Input x0: "), readreal(X0), assert(x0(X0)),
        write("Input y0: "), readreal(Y0), assert(y0(Y0)),
        write("Input a: "),  readreal(A),  validate(A, "Wrong parameter a"), assert(a(A)),
        write("Input m: "),  readreal(M),  assert(m(M)),
        write("Input r: "),  readreal(R),  assert(r(R)), validEq().

    validEq() :-
        m(M), r(R), M = 0, R = 0,
        write("The equation is set incorrectly"), nl,
        write("Zero not equal to One"), nl, 
        clear_database, clear_jac, exit;
        true.

    validate(V, STR) :- 
        V = 0, write("Error! division by zero!"), nl,
        write(STR), nl,
        clear_database, exit; 
        V <> 0.

    reverseMatrix(X11,X12,X21,X22, R11,R12,R21,R22) :-
        DET = X11 * X22 - X12 * X21,
        validate(DET, "Zero determinant"),
        %write("det = "), write(DET), nl,
        R11 = X22 / DET, R21 = -X21 / DET,
        R12 = -X12 / DET, R22 = X11 / DET.

    jacobian0(X,Y) :-
        x0(X0), y0(Y0), a(A), m(M), r(R),
        X11 = (2 * X - 2 * X0) / (A * A), assert(jac11(X11)),
        X12 = 2 * Y - 2 * Y0,       assert(jac12(X12)),
        X21 = M,                    assert(jac21(X21)),
        X22 = R,                    assert(jac22(X22)).

    answer(X, Y) :-
        writef("X = %0.3f", X), nl,
        writef("Y = %0.3f", Y), nl.

    checkPrecision(X1, X2, X,Y) :-
        X1*X1 + X2*X2 < 0.0000001 * 0.0000001,
        write("Answer:"), nl, answer(X,Y),
        clear_jac(), clear_database(), readchar(_), exit;
        true.

    anotherBroyden(_,_, Cnt) :-
        Cnt = 1000, clearwindow(), 
        write("Number of steps exceeded"), nl,
        write("No points found"), nl,!.
    anotherBroyden(X,Y, Cnt) :-
        Cnt = 0, 
        F1(X,Y, Fn1), F2(X,Y, Fn2),
        Fn1*Fn1 + Fn2*Fn2 < 0.0000001 * 0.0000001,
        write("Answer:"), nl, answer(X,Y), exit.

    anotherBroyden(X,Y, Cnt) :-
        jac11(Jac11), jac12(Jac12), jac21(Jac21), jac22(Jac22),
        F1(X,Y, Fn1), F2(X,Y, Fn2),
        reverseMatrix(Jac11,Jac12,Jac21,Jac22, RevJac11,RevJac12,RevJac21,RevJac22),
        DeltaXn1 = (RevJac11*Fn1 + RevJac12*Fn2),
        DeltaXn2 = (RevJac21*Fn1 + RevJac22*Fn2),
        Xn1 = X - DeltaXn1, Xn2 = Y - DeltaXn2,
        F1(Xn1, Xn2, NextFn1), F2(Xn1, Xn2, NextFn2), 
        DeltaNextFn1 = NextFn1 - Fn1, DeltaNextFn2 = NextFn2 - Fn2,
        DXn1 = Xn1 - X, Dxn2 = Xn2 - Y,
          test(Cnt, Fn1, Fn2, Xn1, Xn2, X, Y, RevJac11, RevJac12, RevJac21, RevJac22, DXn1, DXn2),
        checkPrecision(DeltaNextFn1,DeltaNextFn2, Xn1,Xn2),

        %denominator
        Denom = DXn1*DXn1 + DXn2*DXn2,
        validate(Denom, "Denomerator while updating Jacobian became zero"),
        
        %numerator
        MUL1 = (Jac11*DXn1 + Jac12*DXn2),
        MUL2 = (Jac21*DXn1 + Jac22*DXn2),
        SUB1 = (DeltaNextFn1 - MUL1) / (Denom * Denom),
        SUB2 = (DeltaNextFn2 - MUL2) / (Denom * Denom),
        %SUB1 = NextFn1 - MUL1,
        %SUB2 = NextFn2 - MUL2,
        MulDelta11 = SUB1 * DXn1, MulDelta12 = SUB1 * DXn2,
        MulDelta21 = SUB2 * DXn1, MulDelta22 = SUB2 * DXn2,

        clear_jac(),
        NewJac11 = Jac11 + MulDelta11, assert(jac11(NewJac11)),
        NewJac12 = Jac12 + MulDelta12, assert(jac12(NewJac12)),
        NewJac21 = Jac21 + MulDelta21, assert(jac21(NewJac21)),
        NewJac22 = Jac22 + MulDelta22, assert(jac22(NewJac22)),
        Cnt1 = Cnt + 1,
        anotherBroyden(Xn1, Xn2, Cnt1).

    test(Cnt, Fn1, Fn2, Xn1, Xn2, X,Y, RevJac11, RevJac12, RevJac21, RevJac22, DeltaXn1, DeltaXn2) :-
        clearwindow(),
        jac11(Jac11), jac12(Jac12), jac21(Jac21), jac22(Jac22),
        write("Jac:"), nl,
        write(Jac11),write(" "),write(Jac12),nl,write(Jac21),write(" "),write(Jac22),nl,
        write("RevJac:"), nl,
        write(RevJac11),write(" "),write(RevJac12),nl,write(RevJac21),write(" "),write(RevJac22),nl,
        write("Func:"),nl,
        write(" "), write(Fn1), write(" "), write(Fn2), nl,
        write("Xn + X:"),nl,
        write(Xn1), write(" "), write(X),nl, write(Xn2), write(" "), write(Y), nl,
        write("DeltaX:"),nl,
        write(DeltaXn1), write(" "), write(DeltaXn2), write(" "), nl,
        write("Count = "), write(Cnt), nl,
        readchar(_).


    startBroyden(X,Y) :-
        jacobian0(X,Y),
        broyden(X,Y, 0).
        %anotherBroyden(X,Y, 0).

    inputPoint(X,Y) :-
        write("Input X: "), readreal(X),
        write("Input Y: "), readreal(Y).

    start() :-
        clearwindow(),
        input(), clearwindow(),
        inputPoint(X,Y), clearwindow(),
        clear_database(),
        clear_jac(),
          %assert(x0(0)), assert(y0(0)), assert(a(1)), assert(m(0)), assert(r(1)),
          %assert(x0(4)), assert(y0(4)), assert(a(3)), assert(m(0)), assert(r(0)),
        startBroyden(X,Y),
        clear_database(),
        clear_jac().
        
%goal
