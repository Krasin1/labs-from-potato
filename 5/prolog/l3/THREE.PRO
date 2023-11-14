domains
    x = real
    z = integer
    list = real*
    list_lists = list*
    file = text_file
database
    
predicates
    write_list(list)
    read_list(list, list_lists)

    append(list, list, list)
    last(x, list)
    make_stacks(x, list_lists, list_lists)

clauses
    append([], List2, List2).
    append([Head|Tail], List2, [Head|TailResult]):-
        append(Tail, List2, TailResult).

    last(X, [X]).
    last(X, [_|Z]) :- last(X,Z).
    
    read_list([X|T], NewList) :-
        readreal(X),
        make_stacks(X, List, NewList),
        read_list(T, List).

    read_list([], NewList).

    write_list([]):-!.
    write_list([Head|Tail]):-
        write(Head), nl, write_list(Tail).

    make_stacks(X, [[Head|Tail]|TAILL], NewList) :-
        last(LAST, [Head|Tail]), LAST >= X, append([Head|Tail], [X], [NewHead|NewTail]),
        NewList = [[NewHead|NewTail] | TAILL];

        make_stacks(X, TAILL, NewList).

    make_stacks(X, [[Head|Tail]|[]], NewList) :-
        append([Head|Tail], [X], [NewHead|NewTail]),
        NewList = [[NewHead|NewTail] | []].
        
        
        
        
goal
    existfile("C:/LABS/L3/num.txt"),!,
    openread(text_file, "C:/LABS/L3/num.txt"),
    readdevice(text_file),
    read_list(Input_list, NewList),
    %write_list(Input_list),
    closefile(text_file);
    write("cant open file"),nl.
