domains
    x = real
    z = integer
database
    resPoints(x,x)
    check(z)
predicates
    print()
    printPoints()
    empty_database()
    clear_database()
    readChoice(z)
    process(z)
    menu()
    error()
    repeat()
    deg90(x,x, x,x, x,x, x,x)
    cross(x,x, x,x, x,x, x,x, x,x)
    isCross(x,x, x,x, x,x, x,x)
    insert(x,x, x,x, x,x, x,x)
    point(x,x)
    insertSquare(x,x, x,x, x,x, x,x)
    insertRhombus(x,x, x,x, x,x, x,x)
    length(x,x, x,x, x)
    sameLength(x,x, x,x, x,x, x,x)
    isRhombus(x,x, x,x, x,x, x,x)
    isSquare(x,x, x,x, x,x, x,x)
    intersections(x,x, x,x, x,x, x,x, x,x, x,x, x,x, x,x, x,x)
    result(x,x)
    cosoe(x,x, x,x, x,x, x)
    onLine(x,x, x,x, x,x, x,x, x,x)
    inLine(x,x, x,x, x,x)
    huh(x,x, x)
    onBothSides(x,x, x,x, x,x, x,x, x,x,x,x)
    fillDB()
    maximum(x,x, x)
    minimum(x,x, x)

clauses
    maximum(X,Y, Z) :- 
        X >= Y, Z = X;
        Y >= X, Z = Y.

    minimum(X,Y, Z) :- 
        X <= Y, Z = X;
        Y <= X, Z = Y.

    onBothSides(X1,Y1, X2,Y2, A1,B1, A2,B2, ANS1,ANS2,ANS3,ANS4) :-
        cosoe(X1,Y1, X2,Y2, A1,B1, ANS1), ANS1<>0,
        cosoe(X1,Y1, X2,Y2, A2,B2, ANS2), ANS2<>0,
        cosoe(A1,B1, A2,B2, X1,Y1, ANS3), ANS3<>0,
        cosoe(A1,B1, A2,B2, X2,Y2, ANS4), ANS4<>0.
    
    cosoe(X1,Y1, X2,Y2, A,B, ANS) :-
        AB1 = X2 - X1, AB2 = Y2 - Y1,
        C1 = A - X1, C2 = B - Y1,
        ANS = AB1*C2 - C1*AB2.

    isCross(X1,Y1, X2,Y2, A1,B1, A2,B2) :-
        onBothSides(X1,Y1, X2,Y2, A1,B1, A2,B2, ANS1,ANS2,ANS3,ANS4),
        ANS1*ANS2 < 0, ANS3*ANS4 < 0.

        
    result(X,Y) :-
        insertSquare(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        insertRhombus(A1,B1, A2,B2, A3,B3, A4,B4),
        intersections(X1,Y1,X2,Y2,X3,Y3,X4,Y4, A1,B1,A2,B2,A3,B3,A4,B4, X,Y).

    intersections(X1,Y1,X2,Y2,X3,Y3,X4,Y4, A1,B1,A2,B2,A3,B3,A4,B4, X,Y) :-
        cross(X1,Y1, X2,Y2, A1,B1, A2,B2, X,Y);
        cross(X1,Y1, X2,Y2, A2,B2, A3,B3, X,Y);
        cross(X1,Y1, X2,Y2, A3,B3, A4,B4, X,Y);
        cross(X1,Y1, X2,Y2, A4,B4, A1,B1, X,Y);

        cross(X2,Y2, X3,Y3, A1,B1, A2,B2, X,Y);
        cross(X2,Y2, X3,Y3, A2,B2, A3,B3, X,Y);
        cross(X2,Y2, X3,Y3, A3,B3, A4,B4, X,Y);
        cross(X2,Y2, X3,Y3, A4,B4, A1,B1, X,Y);
        
        cross(X3,Y3, X4,Y4, A1,B1, A2,B2, X,Y);
        cross(X3,Y3, X4,Y4, A2,B2, A3,B3, X,Y);
        cross(X3,Y3, X4,Y4, A3,B3, A4,B4, X,Y);
        cross(X3,Y3, X4,Y4, A4,B4, A1,B1, X,Y);

        cross(X4,Y4, X1,Y1, A1,B1, A2,B2, X,Y);
        cross(X4,Y4, X1,Y1, A2,B2, A3,B3, X,Y);
        cross(X4,Y4, X1,Y1, A3,B3, A4,B4, X,Y);
        cross(X4,Y4, X1,Y1, A4,B4, A1,B1, X,Y).

    isSquare(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :- 
        sameLength(X1,Y1, X2,Y2, X3,Y3, X4,Y4), 
        deg90(X1,Y1, X3,Y3, X2,Y2, X4,Y4),
        cross(X1,Y1, X3,Y3, X2,Y2, X4,Y4, _,_),
        deg90(X1,Y1, X2,Y2, X2,Y2, X3,Y3),
        deg90(X1,Y1, X4,Y4, X4,Y4, X3,Y3);

        write("Wrong Figure"), nl, fail.


    isRhombus(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :- 
        sameLength(X1,Y1, X2,Y2, X3,Y3, X4,Y4), 
        deg90(X1,Y1, X3,Y3, X2,Y2, X4,Y4),
        cross(X1,Y1, X3,Y3, X2,Y2, X4,Y4, _,_);

        write("Wrong Figure"), nl, fail.
        
    sameLength(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :-
        length(X1,Y1, X2,Y2, ANS1), ANS1<>0,
        length(X2,Y2, X3,Y3, ANS2), ANS2<>0,
        length(X3,Y3, X4,Y4, ANS3), ANS3<>0,
        length(X4,Y4, X1,Y1, ANS4), ANS4<>0,
        ANS1 = ANS2, ANS2 = ANS3, ANS3 = ANS4, ANS1 = ANS4.

    length(X1,Y1, X2,Y2, ANS) :-
        ANS = sqrt((X2 - X1)*(X2 - X1) + (Y2 - Y1)*(Y2 - Y1)).

    point(X, Y) :- 
        nl, write("X = "), readreal(X),
        write("Y = "), readreal(Y), nl.

    insertSquare(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :-
        makewindow(4,11,3,"Square",10,30,10,40),shiftwindow(4),
        write("Input coordinates"), nl,
        write(" !!! Fill them in a circle !!! "), nl,
        insert(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        isSquare(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        removewindow.

    insertRhombus(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :-
        makewindow(4,11,3,"Rhombus",10,30,10,40),shiftwindow(4),
        write("Input coordinates"), nl,
        write(" !!! Fill them in a circle !!! "), nl,
        insert(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        isRhombus(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        removewindow.

    insert(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :-
        write("Point 1"), point(X1,Y1), 
        write("Point 2"), point(X2,Y2), 
        write("Point 3"), point(X3,Y3), 
        write("Point 4"), point(X4,Y4).

    deg90(X1,Y1, X2,Y2, X3,Y3, X4,Y4) :-
        AB1 = X2 - X1, AB2 = Y2 - Y1,
        CD1 = X4 - X3, CD2 = Y4 - Y3,
        Res = AB1*CD1 + AB2*CD2, Res = 0.

    onLine(X1,Y1, X2,Y2, X3,Y3, X4,Y4, A1,B1) :-
        cosoe(X1,Y1, X2,Y2, X3,Y3, ANS1), ANS1 = 0, inLine(X1,Y1, X2,Y2, X3,Y3), 
        cosoe(X1,Y1, X2,Y2, X4,Y4, ANS2), ANS2 = 0, inLine(X1,Y1, X2,Y2, X4,Y4), 
        assert(check(1)),

        cosoe(X3,Y3, X4,Y4, X1,Y1, ANS3), ANS3 = 0, inLine(X3,Y3, X4,Y4, X1,Y1), 
        cosoe(X3,Y3, X4,Y4, X2,Y2, ANS4), ANS4 = 0, inLine(X3,Y3, X4,Y4, X2,Y2), 
        assert(check(1)),

        cosoe(X1,Y1, X2,Y2, X3,Y3, ANS1), ANS1 = 0, 
        inLine(X1,Y1, X2,Y2, X3,Y3), A1 = X3, B1 = Y3;
        cosoe(X1,Y1, X2,Y2, X4,Y4, ANS2), ANS2 = 0, 
        inLine(X1,Y1, X2,Y2, X4,Y4), A1 = X4, B1 = Y4;
        cosoe(X3,Y3, X4,Y4, X1,Y1, ANS3), ANS3 = 0, 
        inLine(X3,Y3, X4,Y4, X1,Y1), A1 = X1, B1 = Y1;
        cosoe(X3,Y3, X4,Y4, X2,Y2, ANS4), ANS4 = 0, 
        inLine(X3,Y3, X4,Y4, X2,Y2), A1 = X2, B1 = Y2.

    huh(X,Y, A) :-
        maximum(X, Y, MAX), minimum(X,Y, MIN),
        A <= MAX, A >= MIN.

    inLine(X1,Y1, X2,Y2, X,Y) :- 
        huh(X1,X2, X), huh(Y1,Y2, Y).

    cross(X1,Y1, X2,Y2, X3,Y3, X4,Y4, A1,B1) :- 
        isCross(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        Temp1 = Y2 - Y1, Temp1 <> 0,
        Q = (X2 - X1) / (Y1 -Y2),
        SN = (X3 - X4) + (Y3 - Y4) * Q, SN <> 0,
        FN = (X3 - X1) + (Y3 - Y1) * Q,
        N = FN / SN,
        A1 = X3 + (X4 - X3) * N,
        B1 = Y3 + (Y4 - Y3) * N;

        isCross(X1,Y1, X2,Y2, X3,Y3, X4,Y4),
        Temp1 = Y2 - Y1, Temp1 = 0,
        Temp2 = Y3 - Y4, Temp2 <> 0,
        N = (Y3 - Y1) / (Y3 - Y4),
        A1 = X3 + (X4 - X3) * N,
        B1 = Y3 + (Y4 - Y3) * N;

        onLine(X1,Y1, X2,Y2, X3,Y3, X4,Y4, A1,B1).

    repeat.
    repeat :- repeat.

    error :-
        write("Error"), nl,
        write("Press any button..."), readchar(_), menu.

    readChoice(Vibor):- 
        readint(Vibor);
        error, Vibor = 0,
        menu.

    menu :- 
        makewindow(1,11,3,"Square and rhombus",0,0,25,80),
        repeat, clearwindow, nl,
        write("Intersection points of a Square and a Rhombus"),nl,
        write(" *********************** "), nl,
        write(" * 1. Start execution  * "), nl,
        write(" * 2. Exit             * "), nl,
        write(" *********************** "), nl,
        write(" Choose number 1-2 : "),
        readChoice(Vibor),nl,
        process(Vibor).


    fillDB() :-
        result(X,Y),not(resPoints(X,Y)), assert(resPoints(X,Y)),
        fail.

    printPoints() :- 
        resPoints(X,Y),
        write(" X = "), write(X), write(" "),
        write(" Y = "), write(Y), nl, fail.

    print() :-
        not(check(1)),
        makewindow(3,11,3,"Result Points",2,20,18,58), shiftwindow(3),
        clearwindow(),
        not(printPoints()),
        write("Press any button..."), readchar(_),
        clear_database,
        removewindow, menu;
        
        check(1),
        makewindow(3,11,3,"Result Points",2,20,18,58), shiftwindow(3),
        clearwindow(),
        not(printPoints()),nl,
        write(" !!! Infinite number of points !!! "), nl, nl,
        write("Press any button..."), readchar(_),
        clear_database,
        removewindow, menu.
        
    process(1) :-
        not(fillDB()),
        not(empty_database()),
        clearwindow(), write("We do not look here"),
        not(print()),
        menu();

        empty_database(), 
        clearwindow(),
        write("Wrong input or No points found"), nl,
        write("Press any button..."), readchar(_),
        clear_database,
        menu().

    process(2) :-
        write("See you again! "),readchar(_),exit.

    empty_database :-
        not(resPoints(_,_)).

    clear_database:-
        retract(check(_)),
        retract(resPoints(_,_)),
        fail.
    clear_database:-!.

goal
    menu()
