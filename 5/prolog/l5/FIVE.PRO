%trace
domains
    manifacturer, country, part_number, name = string
    id, count = integer
    price = real
    file = datafile
    arr = string*
    integers = integer*
database
    only_fans(id, manifacturer, part_number, name, count, price)
    last_id(integer)
predicates
    clear_database()
    choose(integer)
    menu()
    process(integer)
    search(integer)
    newLastId(integer)
    incrementLastId(integer) 

    readRows()
    readValue(string,string,string) 
    writeCsv()

    printRows()
    printRow(integer)
    printLegend()

    substr(string, string)
    substr(string,string,string,string)     
    comparison(string,string,integer)   
    searchName(string) 
    searchPartNumber(string) 

    getCountry(string, string)
    pretty(string,string,string,string,string,string,string) 
    checkLen(integer, string,string,string) 
    writeSpaces(integer)
    specialWrite(integer, string) 
clauses
    getCountry("Luzar", "Russia").
    getCountry("Kortex", "South Korea").
    getCountry("Nty", "Poland").
    getCountry("DEQST", "China").
    getCountry("Kale", "Turkish").
    getCountry("Magneti Marelli", "Italy").
    getCountry("Nissens", "Denmark").
    getCountry("Nrf", "Netherlands").
    getCountry("Nrf", "Netherlands").
    getCountry("Stron", "Korea").
    getCountry("Tuc", "Taiwan").
    getCountry("Valeo", "France").
    getCountry("Valeo", "France").
    getCountry("B/U zapchasti", "-").
    getCountry(_, "-").
    

    substr(_,""):-!.
    substr("",_):-!,fail.
    substr(S,SS):-
        frontchar(S,SC,S_),
        frontchar(SS,SC,SS_),
        substr(S_,SS_).
    substr(S,SS):-
        frontchar(S,_,S_),
        substr(S_,SS).
        
    substr(_,"",R,R):-!.
    substr("",_,_,""):-!.
    substr(S,SS,RT,R):-
        frontchar(S,SC,S_),
        frontchar(SS,SC,SS_),
        substr(S_,SS_,RT,R).
    substr(S,SS,_,R):-
        frontchar(S,_,S_),
        substr(S_,SS,S_,R).
        
    comparison("","",0):-!.
    comparison(_,"",1):-!.
    comparison("",_,-1):-!.
    comparison(S1,S2,R):-
        frontchar(S1,C,S1_),
        frontchar(S2,C,S2_),
        comparison(S1_,S2_,R);
        frontchar(S1,C1,_),
        frontchar(S2,C2,_),
        C1<C2,R=-1,!;
        R=1,!.
        

        
    choose(X) :-
        readint(X);
        write("Wrong number"), readchar(_), X = 0,
        menu.

    clear_database:-
        retract(last_id(_)),
        retract(only_fans(_,_,_,_,_,_)),
        fail.
    clear_database:-!.

    incrementLastId(X) :-
        retract(last_id(Id)),
        X = Id + 1,
        assert(last_id(X));
        X = 1,
        assert(last_id(X)).

    newLastId(X) :-
        last_id(Last), Last < X,
        retract(last_id(_)),
        assert(last_id(X)),!.
    newLastId(_).



    printRows() :-
        only_fans(X1,_,_,_,_,_),
        printRow(X1),
        readchar(A), A = 27.
    printRows().

    printLegend() :-
        write("Id  Manifac  Country  Part_Num   Product_Name                    Count  Price"),nl,
        write("    turer             ber"),nl,
        write("------------------------------------------------------------------------------").

    printRow(Id) :-
        only_fans(Id, X2, X3, X4, X5, X6),
        str_int(IdString, Id), str_int(CountString, X5), str_real(PriceString, X6),
        getCountry(X2, Country), 
        pretty(IdString, X2, Country, X3, X4, CountString, PriceString),!.

    specialWrite(Len, String) :-
        str_len(String, StrLen),
        StrLen = Len, write(String),!;

        str_len(String, StrLen),
        SUB = Len - StrLen, 
        write(String), writeSpaces(SUB).

    writeSpaces(0).
    writeSpaces(X) :-
        New = X - 1, write(" "),
        writeSpaces(New).

    checkLen(Len, String, A, B) :-
        str_len(String, StrLen),
        StrLen <= Len, 
        A = String, B = "",!;
        frontstr(Len, String, A, B),!.
        
    pretty("","","","","","","").
    pretty(X1,X2,X3,X4,X5,X6,X7) :-
        checkLen(3, X1, X11, X12), specialWrite(3, X11), write("  "),
        checkLen(7, X2, X21, X22), specialWrite(7, X21), write("  "),
        checkLen(7, X3, X31, X32), specialWrite(7, X31), write("  "),
        checkLen(8, X4, X41, X42), specialWrite(8, X41), write("  "),
        checkLen(31,X5, X51, X52), specialWrite(31,X51), write("  "),
        checkLen(5, X6, X61, X62), specialWrite(5, X61), write("  "),
        checkLen(5, X7, X71, X72), specialWrite(5, X71), 
        pretty(X12,X22,X32,X42,X52,X62,X72).
        

    writeCsv() :-
        only_fans(X1,X2,X3,X4,X5,X6),
        writef("%d;%s;%s;%s;%d;%f\n",X1,X2,X3,X4,X5,X6), fail.
    writeCsv().


    readRows() :-
        readln(Line),
        readValue(Line,  X1, Tail1), str_int(X1, Id),
        readValue(Tail1, X2, Tail2), 
        readValue(Tail2, X3, Tail3), 
        readValue(Tail3, X4, Tail4), 
        readValue(Tail4, X5, Tail5), str_int(X5, Count),
        readValue(Tail5, X6, _),     str_real(X6, Price),
        assertz(only_fans(Id, X2, X3, X4, Count, Price)), newLastId(Id), !, 
        readRows();

        not(eof(datafile)), !,
        write(" Reading error"),nl,
        write(" Only some data opened"),nl;

        !.

    readValue("", "", "") :- !.
    readValue(Line, X, Tail) :-
        frontchar(Line, LineH, LineT),
        LineH = ';', !,
        X = "", Tail = LineT;

        frontchar(Line, LineH, LineT),
        LineH <> ';', 
        readValue(LineT, T, Tail),
        str_char(LineHS, LineH),
        concat(LineHS, T, X).

    menu :-
        makewindow(1,23,65, "Only Fans for Pegeot 408 TU5JP5",0, 0,25,80),
        clearwindow,nl,
        write(" ---------------- "),nl,
        write(" 1 - Read database from .csv"), nl,
        write(" 2 - Read database from prolog file"), nl,
        write(" 3 - Show database"), nl,
        write(" 4 - Add row "), nl, 
        write(" 5 - Delete row "), nl, 
        write(" 6 - Edit row"), nl,
        write(" 7 - Find row"), nl, 
        write(" 8 - Write database to .csv"), nl,
        write(" 9 - Write database to prolog file"), nl,
        write(" 10 - Clear database"), nl,
        write(" 11 - Exit"), nl,
        write(" ---------------- "),nl,
        write(" Choose number 1-11: "),
        choose(X), nl, process(X).

    process(1) :-
        makewindow(2,23,65, "Read database from .csv", 2, 30, 15, 40), 
        write(" Input file name: "), readln(FileName), 
        concat("C:/LABS/L5/", FileName, File),
        existfile(File), clear_database,
        openread(datafile, File), readdevice(datafile),
        readRows(),
        closefile(datafile), readdevice(keyboard),
        write(" DB successfully read from file."), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;

        write(" Error reading file!"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(2) :-
        makewindow(3,23,65, "Read database from prolog file", 2, 30, 15, 40), 
        write(" Input file name: "), readln(FileName), 
        concat("C:/LABS/L5/", FileName, File),
        existfile(File), clear_database,
        consult(File),
        write(" DB successfully read from file."), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;

        write(" Error reading file!"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(3) :-
        makewindow(4,23,65,  " All database ",0, 0,25,80), shiftwindow(4),
        printLegend(), printRows(),!,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu.

    process(4) :-
        makewindow(5,23,65, " Add fan " ,0,0, 20,80), shiftwindow(5),
        write(" Fill next fields:"),nl,
        write(" Manifacturer: "), readln(Manifacturer),nl,
        write(" Part number: "), readln(PartNumber),nl,
        write(" Product name: "), readln(Name),nl,
        write(" Count in stock: "), readint(Count), Count >= 0, nl,
        write(" Price: "), readreal(Price), Price >= 0, nl,
        incrementLastId(Id),
        assertz(only_fans(Id, Manifacturer, PartNumber, Name, Count, Price)),
        write(" Entry successfully added to database"),nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;
        
        write(" Something went wrong"),nl,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(5) :-
        makewindow(6,23,65, " Delete fan " ,0,0,20,80), shiftwindow(6),
        write(" Input Id of row: "), readint(Id),nl, 
        printLegend(), printrow(Id), 
        retract(only_fans(Id,_,_,_,_,_)), 
        write(" This row was deleted"),nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;
        
        write(" No data"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(6) :-
        makewindow(7,23,65, " Edit fan " ,0,0,20,80), shiftwindow(7),
        write(" Input Id of row: "), readint(Id),
        printLegend(), printrow(Id), nl,
        write(" Fill next fields:"),nl,
        write(" Manifacturer: "), readln(Manifacturer),nl,
        write(" Part number: "), readln(PartNumber),nl,
        write(" Product name: "), readln(Name),nl,
        write(" Count in stock: "), readint(Count), Count >= 0, nl,
        write(" Price: "), readreal(Price), Price >= 0, nl,
        retract(only_fans(Id,_,_,_,_,_)), 
        assertz(only_fans(Id, Manifacturer, PartNumber, Name, Count, Price)),
        write(" Row was successfully modified"),nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;

        write(" Wrong input"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(7) :-
        makewindow(8,23,65, " Find fan ",0, 0,25,80), shiftwindow(8),
        clearwindow,nl,
        write( " 1 - By id"), nl,
        write( " 2 - By Part Number"), nl,
        write( " 3 - By Product name"), nl,
        write( " 4 - Exit"), nl,
        write(" Choose number 1-4: "),
        choose(X), clearwindow,
        search(X),!,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;

        write(" Wrong input"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(8) :-
        makewindow(9,23,65, "Write database to .csv", 2, 30, 15, 40), shiftwindow(9),
        write("Input file name: "), readln(FileName), 
        concat("C:/LABS/L5/", FileName, File),
        openwrite(datafile, File), writedevice(datafile),
        writeCsv(),
        closefile(datafile), writedevice(screen),
        write(" DB successfully saved to file."), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;

        write(" Error writing database!"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(9) :-
        makewindow(10,23,65, "Write database to prolog file", 2, 30, 15, 40), shiftwindow(10),
        write("Input file name: "), readln(FileName), 
        concat("C:/LABS/L5/", FileName, File),
        save(File),
        write(" DB successfully saved to file."), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;
        
        write(" Error writing database!"), nl, !,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(10) :-
        makewindow(11,23,65, " Clear database " ,7,40,10,30), shiftwindow(11),
        clear_database,
        write(" Done "), nl,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu;
        
        write(" Error while delete db "), nl,
        write(" Press any key..."), readchar(_), 
        removewindow, clearwindow, menu, fail.

    process(11) :-
        write("See you again! "),readchar(_),exit.



    search(1) :-
        write(" Input Id of row: "), readint(Id),
        printLegend(), printrow(Id),nl,!;

        write(" No entries found"),nl,!,
        write(" Press any key..."), readchar(_),
        removewindow, clearwindow, process(7), fail.

    search(2) :-
        write(" Input part number: "), readln(Line),
        clearwindow,write(" Press any key to see next result or ESC to finish..."), nl,
        printLegend(),
        searchPartNumber(Line),!;

        write(" No entries found"),nl,
        write(" Press any key..."), readchar(_),
        removewindow, clearwindow, process(7), fail.

    search(3) :-
        write(" Input product name: "), readln(Line), nl,
        clearwindow,write(" Press any key to see next result or ESC to finish..."), nl,
        printLegend(),
        searchName(Line),!;

        write(" No entries found"),nl,
        write(" Press any key..."), readchar(_),
        removewindow, clearwindow, process(7), fail.

    search(4) :-
        removewindow, clearwindow, menu.

    searchName(Line) :-
        only_fans(Id,_,_,Name,_,_), substr(Name, Line),
        printRow(Id),
        readchar(A), A = 27, 
        removewindow, clearwindow, menu.

    searchPartNumber(Line) :-
        only_fans(Id,_,PartNumber,_,_,_), substr(PartNumber, Line),
        printRow(Id),
        readchar(A), A = 27, 
        removewindow, clearwindow, menu.

goal
    menu.
