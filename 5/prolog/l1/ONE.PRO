domains
    name = symbol
    dad, mom, sex = symbol
predicates
    person(name, dad, mom, sex)
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
    nephew(person, person)
    niece(person, person)
    father-in-law(person, person)
    mother-in-law(person, person)
    patent(person, person)
    relative(person, person)

clauses
    person(vlad, zhenya, natasha, male).
    person(dima, zhenya, natasha, male).
    person(zhenya, tolya, sveta, male).
    person(vova, tolya, sveta, male).
    person(natasha, tolya, nina, female).
    person(serezha, tolya, nina, female).
    person(nikita, serezha, tanya, male).
    person(ilya, vova, ulya, male).

    mom(


