domains
    gorod, strana = symbol
predicates
    situ(gorod, strana)
clauses
    situ(london, england).
    situ(petersburg, russia).
    situ(kiev, ukraine).
    situ(warszawa, poland).
    situ(berlin, europe).
    situ(X, europe) :- situ(X, russia).
    situ(X, europe) :- situ(X, poland).
    %my added lines :D
    situ(kiev, X) :- situ(petersburg, X).
    situ(X, europe) :- situ(X, latvia).
    situ(muxosransk, russia).
    situ(riga, latvia).