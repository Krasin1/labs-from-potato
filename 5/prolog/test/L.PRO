domains
    x = real
    z = integer
    list = real*
    list_lists = list*
    
predicates
    last(x, list)
    kek(list_lists)

clauses

    last(X, [X]).
    last(X, [_|Z]) :- last(X,Z).

    kek([[Head|Tail]|Taill]) :-
        last(LAST, [Head|Tail]), write(LAST), nl.

goal
    kek([[0,1,2], [0,10], [0,0,0,0,1,1,2]]).
    %last(LAST, [0,1,2,3,4]), write(LAST), nl.
