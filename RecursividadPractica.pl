progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro,Descendiente):- progenitor(Progenitor, Descendiente),
ancestro(Ancestro, Progenitor).


ultimo([E],E).
ultimo([_|Cola],Ultimo):- ultimo(Cola,Ultimo).


sumatoria([], 0).
sumatoria([Cabeza|Cola], S):-sumatoria(Cola,SCola), S is SCola + Cabeza.

cabeza([Cab|_], Cab).

% a
encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola], [Cab|Resto]):-encolar(Elem, Cola, Resto).

%b
maximo(Lista, Max):- member(Max, Lista), 
    forall(member(Elem, Lista), Max >= Elem).

maximoBis(Lista, Max):- member(Max, Lista), 
    forall((member(Elem, Lista), Elem \= Max), Max > Elem).

maximoRecursivo([Max], Max).
maximoRecursivo([Cab, OtraCab| Cola], Max):- Cab > OtraCab, 
    maximoRecursivo([Cab | Cola], Max).
maximoRecursivo([Cab, OtraCab | Cola], Max):- OtraCab >= Cab, 
    maximoRecursivo([OtraCab |Cola], Max).


% c
unirSinRepetidos([], Lista2, Lista2).
unirSinRepetidos([Cab| Cola], Lista2, [Cab| Resto]):- not(member(Cab, Lista2)), 
    unirSinRepetidos(Cola,Lista2, Resto).
unirSinRepetidos([Cab| Cola], Lista2, Lista3):- member(Cab, Lista2), 
    unirSinRepetidos(Cola, Lista2, Lista3).

% d
interseccion(Lista, OtraLista, Interseccion):-
    findall(Elem, (member(Elem, Lista), member(Elem, OtraLista)), Interseccion).

% e
esCreciente([_]).
esCreciente([Elem, OtroElem | Resto]):- Elem < OtroElem, 
    esCreciente([OtroElem | Resto]).

%f
sublistaMayoresA([], _, []).
sublistaMayoresA([Cab|Resto], Elem, [Cab|OtroResto]):- Elem < Cab, 
    	sublistaMayoresA(Resto, Elem, OtroResto).
sublistaMayoresA([_|Resto], Elem, OtraLista):- 
    	sublistaMayoresA(Resto, Elem, OtraLista).

entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 30).
costo(teatro, 40).
costo(pool, 15).
costo(parqueTematico, 50).

entretenimientos(Disponible, Lugares):-entretenimientosPosibles(EntrePosibles),
    alcanzaPara(EntrePosibles, Disponible, Lugares).

entretenimientosPosibles(ListaEntretenimientos):-
    findall(Entretenimiento, entretenimiento(Entretenimiento), ListaEntretenimientos).

alcanzaPara([], _, []).
alcanzaPara([Entre| Resto], Disponible , [Entre| RestoLista]):- costo(Entre, Monto), Monto =< Disponible, 
    	RestoDisponible is Disponible - Monto, 
    	alcanzaPara(Resto, RestoDisponible, RestoLista).
alcanzaPara([_|Resto], Disponible, Lista):- alcanzaPara(Resto, Disponible, Lista).