nowarnings
%trace
domains
    x = real
    list = real*
    list_lists = list*
    file = text_file
predicates
    sort()

    min(list_lists, x)
    min(list_lists, x, x)
    replace(list_lists,list,list,list_lists)
    remove(list,list_lists,list_lists)
    remove(x,list,list)

    emptyFile(list)
    readList(list)
    writeList(list)
    writeStack(list_lists)

    toStack(list, list_lists)
    toStack(list, list_lists, list_lists)

    result(list_lists, list)
    result(x, list_lists, list)

    pushToPile(x, list, list)
    findLessX(x, list_lists, list)
    pushX(x, list_lists, list_lists)
    popX(x,list_lists, list_lists)
    findX(x, list, list_lists)
clauses
    replace([], _, NewValue, [NewValue]):-!.
    replace([OldValue|Tail], OldValue, NewValue, [NewValue|Tail]).
    replace([Head|Tail], OldValue, NewValue, [Head|ReplacedTail]):-
      replace(Tail, OldValue, NewValue, ReplacedTail).

    remove(_,[],[]).
    remove(Head,[Head|Tail],Tail) :- !.
    remove(X,[Head|Tail],[Head|Tail2]) :- remove(X,Tail,Tail2).

    min([[Head|_]|Tail], Min) :-
        min(Tail, Head, Min).
    min([], Min, Min).
    min([[Head|_]|Tail], Old, Min) :- 
        Old < Head, min(Tail, Old, Min);
        Old >= Head, min(Tail, Head, Min).

    emptyFile(List) :-
        not(List = []);
        write("Error: empty file"),nl,exit.

    readList([Head|Tail]):-
        readreal(Head),
        readList(Tail);
        readchar(_),
        write("Error while reading file"), exit.
    readList([]).

    writeList([]):-nl,!.
    writeList([Head|Tail]):-
        write(Head), write(" "), writeList(Tail).

    writeStack([]):-nl,!.
    writeStack([Head|Tail]):-
        writeList(Head), writeStack(Tail).

    popX(X,NewStack, Stack) :-
        findX(X,Pile, Stack),
        remove(X, Pile, NewPile),
        not(NewPile = []), replace(Stack, Pile, NewPile, NewStack),!;
        findX(X,Pile, Stack),
        remove(Pile, Stack, NewStack),!.
    
    findX(X,Pile, [[Head|T]|Tail]) :-
        X = Head, Pile = [Head|T],!;
        findX(X, Pile, Tail).
    
    result(Stack, List) :-
        min(Stack, Min),
        result(Min, Stack, List).
    result(Min, Stack, [ResHead|ResTail]) :-
        popX(Min, NewStack, Stack),
        not(NewStack = []),
        ResHead = Min,
        min(NewStack, NewMin),
        result(NewMin, NewStack, ResTail);
        ResHead = Min,
        result(_,[],[]).
    result(_,[],[]):-!.

    findLessX(X, [ [Head|T] | Tail], Pile) :-
        X <= Head, Pile = [Head|T],!;
        findLessX(X, Tail, Pile).
    findLessX(_, [], []):-!.

    pushX(X, Stack, NewStack) :-
        findLessX(X, Stack, OldPile),
        pushToPile(X, OldPile, NewPile),
        replace(Stack, OldPile, NewPile, NewStack).

    toStack(List, NewStack):-
        toStack(List,[],NewStack).

    toStack([Head|Tail], Stack, NewStack) :-
        pushX(Head, Stack, NS),
        toStack(Tail,NS,NewStack).
    toStack([],NewStack, NewStack).

    pushToPile(X, [Head|Tail], List) :-
        X > Head, List = [];
        X <= Head, List = [X|[Head|Tail]].
    pushToPile(X, [], [X]).

    sort() :-
        clearwindow, 
        existfile("C:/LABS/L3/num.txt"),!,
        openread(text_file, "C:/LABS/L3/num.txt"),
        readdevice(text_file),
        readList(List),
        emptyFile(List),
        writeList(List),
        toStack(List,Stack),
        %writeStack(Stack),
        result(Stack, Res),
        write("Sorted:"),nl,
        writeList(Res),
        closefile(text_file);
        write("cant open file"),nl.
        
goal
    sort.
