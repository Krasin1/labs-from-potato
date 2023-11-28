%trace
domains
    slist = char*
    list = real*
    way = w(real,slist)
    ways = way*

database
    result(way)
 
predicates
    edge(char,char,real)
    move(char,char,real)
    prolong(way,way)
    place(ways,ways,ways)
    placeone(way,ways,ways)
    search_bst(char,char, way)
    bst(ways,char,way)
    show_answer(slist)
    member(char,slist)

    check_cities(slist, slist)
    correct_list(slist)
    clear_database()
    bruteforce(slist)
    bruteforce(char, slist,slist,slist)
    minimum(way,way,way) 
    min_in_list(ways, way)
    to_list(ways)
    remove(char, slist,slist)
    start()

 
clauses
    edge('a','b', 3).
    edge('a','c', 3).
    edge('b','c', 2).
    edge('c','e', 4).
    edge('e','f', 2).
    edge('c','d', 4.5).
    edge('f','h', 9).
    edge('d','f', 6).
    edge('d','j', 14).
    edge('h','j', 5).
    edge('h','g', 5).
    edge('z','j',150).
    edge('z','h',150).

    move(A,B,C):-edge(A,B,C);edge(B,A,C).

    check_cities([],_).
    check_cities([Head|Tail], Way) :-
        member(Head, Way),
        check_cities(Tail, Way).

    correct_list([]).
    correct_list([Head|Tail]) :-
        edge(Head, _, _),correct_list(Tail);
        edge(_, Head, _),correct_list(Tail).

    member(H,[H|_]).
    member(H,[_|Tail]):-member(H,Tail).
     
    prolong(w(Length,[Temp|Tail]),w(NewLength,[New,Temp|Tail])):-
        move(Temp,New,C),not(member(New,[Temp|Tail])),NewLength=Length+C.
    
    place([],SortedWays,SortedWays).
    place([Way|Tail],PrevWays,SortedWays):-
        placeone(Way,PrevWays,PrevWays1),
        place(Tail,PrevWays1,SortedWays).
     
    placeone(w(Length,Way),[w(LengthH,WayH)|Tail],[w(Length,Way),w(LengthH,WayH)|Tail]):-Length<=LengthH,!.
    placeone(LengthWay,[LengthHWayH|Tail],[LengthHWayH|NewTail]):-placeone(LengthWay,Tail,NewTail).
    placeone(LengthWay,[],[LengthWay]).
     
    bst([w(Length,[Finish|Tail])|_],Finish,w(Length,[Finish|Tail])).
    bst([TempWay|OtherWays],Finish,Way):-
        findall(W,prolong(TempWay,W),Ways),
        place(Ways,OtherWays,NewWays),bst(NewWays,Finish,Way).
     
    show_answer([_]):-!.
    show_answer([A,B|Tail]):-
        show_answer([B|Tail]),nl,write(B),write(" -> "),write(A).

    search_bst(Start,Finish, w(Length,Way)):-
        bst([w(0,[Start])],Finish,w(Length,Way)).


    bruteforce([Head|Tail]) :-
        bruteforce(Head,Tail,Tail, [Head|Tail]).
    bruteforce(X,[],[NextHead|NextTail], TrueList) :-
        remove(X,TrueList, New),
        bruteforce(NextHead, New, NextTail, TrueList).
    bruteforce(_,_,[], _).
    bruteforce(First,[Head|Tail], NextTail, TrueList) :-
        search_bst(First,Head, w(Length, Way)),
        check_cities(TrueList,Way),
        assertz(result(w(Length,Way))),
        bruteforce(First,Tail, NextTail, TrueList);
        
        bruteforce(First,Tail, NextTail, TrueList).

    to_list([]) :- not(result(_)).
    to_list([Head|Tail]) :-
        result(Head),
        retract(result(Head)),
        to_list(Tail).

    minimum(w(X,A),w(Y,C), Z):- 
        X <= Y, Z = w(X,A);
        Y <= X, Z = w(Y,C).

    min_in_list([X],X).
    min_in_list([Head|Tail], Min) :-
        min_in_list(Tail, TempMin),
        minimum(Head, TempMin, Min).

    clear_database:-
        retract(result(_)),
        fail.
    clear_database:-!.

    remove(_,[],[]).
    remove(Head,[Head|Tail],Tail2) :- remove(Head, Tail, Tail2).
    remove(X,[Head|Tail],[Head|Tail2]) :- not(X = Head), remove(X,Tail,Tail2).

    start :-
        clearwindow, clear_database,
        List = ['a', 'z', 'b'],
        correct_list(List),
        bruteforce(List),
        to_list(ResultList),
        min_in_list(ResultList, w(Length,Way)),
        show_answer(Way),nl,write("Length: "), write(Length),nl,
        write("Press any key"),nl,readchar(_),
        clear_database.

goal
    start.
