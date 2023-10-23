domains
    person = symbol
predicates
    male(person)
    female(person)
    married(person,person)
    son(person, person)
    daughter(person, person)
    mom(person, person)
    dad(person, person)
    sis(person, person)
    bro(person, person)
    uncle(person, person)
    aunt(person, person)
    granny(person, person)
    granddaddy(person, person)
    kuzen(person, person)
    kuzina(person, person)
    plemyannik(person, person)
    plemyannitsa(person, person)
    testb(person, person)
    tesha(person, person)
    svekr(person, person)
    svekrov(person, person)
    parent(person, person)
    predok(person,person)
    relative(person, person)
    siblings(person, person)
	dever(person, person)
clauses
    male(vlad).
    male(zhenya).
    male(tolya).
    male(anatolyi).
    male(vova).
    male(serezha).
    male(ilya).
    male(nikita).
    male(viktor).
    male(dima).
    female(natasha).
    female(sveta).
    female(nina).
    female(tanya).
    female(ulya).
    female(luba).

%   married(zhenya, natasha).
%   married(vova, ulya).
%   married(serezha, tanya).
%   married(tolya, sveta).
%   married(anatolyi, nina).
%   married(viktor, luba).

    dad(zhenya, vlad).
    dad(zhenya, dima).
    dad(vova, ilya).
    dad(serezha, nikita).
    dad(tolya, zhenya).
    dad(tolya, vova).
    dad(anatolyi, natasha).
    dad(anatolyi, serezha).
    %dad(viktor
    %dad(viktor
    mom(natasha, vlad).
    mom(natasha, dima).
    mom(ulya, ilya).
    mom(tanya, nikita).
    mom(sveta, zhenya).
    mom(sveta, vova).
    mom(nina, natasha).
    mom(nina, serezha).
    %mom(luba,
    %mom(luba,
    
    son(X, Y) :- male(X), dad(Y,X); male(X), mom(Y,X).
    daughter(X, Y) :- female(X), dad(Y,X); female(X), mom(Y,X).

    married(X, Y) :- female(Y), male(X), mom(Y, Z), dad(X, Z).

    parent(X, Y) :- dad(X, Y); mom(X, Y).

    sis(X, Y) :- female(X), mom(SOME, X), mom(SOME, Y), X<>Y.
    bro(X, Y) :- male(X), mom(SOME, X), mom(SOME, Y), X<>Y.
    siblings(X, Y) :- mom(SOME, X), mom(SOME, Y), X<>Y; dad(SOME, X), dad(SOME, Y), X<>Y.  %bro or sister exist

    uncle(X, Y) :- male(X), bro(BRO, X), dad(BRO, Y); male(X), sis(SIS, X), mom(SIS, Y). 
    aunt(X, Y) :- female(X), sis(X, BRO), dad(BRO, Y); female(X), sis(X, SIS), mom(SIS, Y).

    granny(X, Y) :- parent(SOME, Y), mom(X, SOME).
    granddaddy(X, Y) :- parent(SOME, Y), dad(X, SOME).

    kuzen(X, Y) :- male(X), parent(PARENT, X), siblings(PARENT, SOME), parent(SOME, Y), X<>Y.
    kuzina(X, Y) :- female(X), parent(PARENT, X), siblings(PARENT, SOME), parent(SOME, Y), X<>Y.

    plemyannik(X, Y) :- male(X), parent(PARENT, X), siblings(PARENT, Y).
    plemyannitsa(X, Y) :- female(X), parent(PARENT, X), siblings(PARENT, Y).

    testb(X, Y) :- male(X), male(Y), married(Y, SOME), dad(X, SOME).
    tesha(X, Y) :- female(X), male(Y), married(Y, SOME), mom(X, SOME).

    svekr(X, Y) :-  male(X), female(Y), married(SOME, Y), dad(X, SOME).
    svekrov(X, Y) :- female(X), female(Y), married(SOME, Y), mom(X, SOME).

    predok(X, Y) :- parent(X, Y), X<>Y.
    predok(X, Y) :- parent(X,Z), parent(Z,Y),X<>Y.

    relative(X,Y) :- siblings(X,Y).
    relative(X,Y) :- predok(X,Y); predok(Y,X),X<>Y.
    relative(X,Y) :- predok(Z,X),predok(Z,Y),X<>Y,Z<>X,Z<>Y.
    relative(X,Y) :- predok(Z,X),predok(A,Y),siblings(Z,A),X<>Y,Z<>X,Z<>Y,A<>X,A<>Y.

	dever(X,Y) :- male(X), female(Y), married(Z, Y), bro(Z, X), X<>Y.
   