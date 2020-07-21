% equipoGrande/1 -> qué equipo es grande
equipoGrande(deportivoPlanificador).
equipoGrande(defensoresDelFileSystem).
equipoGrande(procesosUnidos).

% jugo/2 -> relaciona un jugador con un equipo
jugo(molina, deportivoPlanificador).
jugo(molina, defensoresDelFileSystem).
jugo(molina, procesosUnidos).
jugo(bertolini, deportivoPlanificador).
jugo(frasoldatti, chacarita).
jugo(frasoldatti, procesosUnidos).
jugo(frasoldatti, flandria).

consagrade(Jugador):- jugo(Jugador, _), 
    forall(jugo(Jugador, Equipo), equipoGrande(Equipo)).


consagradeNot(Jugador):- jugo(Jugador, _), 
    not((jugo(Jugador, Equipo), not(equipoGrande(Equipo)))).

transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).


tardaMucho(Persona):- transporte(Persona, camina).
tardaMucho(Persona):- transporte(Persona, auto(_, _, _)), manejaLento(Persona).

viajanEnColectivo(Persona):-transporte(Persona, Colectivo), esColectivo(Colectivo).

esColectivo(colectivo(_)).
esColectivo(colectivo(_, _)).

% Punto 2

%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).



puedeIr(Persona, Lugar, Alojamiento):- lugar(Lugar, Alojamiento), cumpleCondiciones(Alojamiento), 
    montoDiario(Alojamiento, MontoDiario), puedeGastar(Persona, CantidadDias, Disponible), 
    Disponible >= MontoDiario * CantidadDias.

cumpleCondiciones(hotel(_, CantEstrellas, _)):-CantEstrellas > 3.
cumpleCondiciones(casa(garaje,_)).
cumpleCondiciones(carpa(__)).
cumpleCondiciones(quinta(_, pileta, _)).

montoDiario(hotel(_, _, MontoDia), MontoDia).
montoDiario(casa(_, MontoDia), MontoDia).
montoDiario(carpa(MontoDia), MontoDia).
montoDiario(quinta(_, _, MontoDiario), MontoDiario).

% Punto 2
puedenIrACualquierLugar(Persona):- persona(Persona), 
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).

persona(Persona):-puedeGastar(Persona, _, _).


genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).


% Punto 2                
peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas):-
    gusta(Persona, _), genero(_, Genero), 
    findall(Pelicula, gustaPorGenero(Persona, Genero, Pelicula), Peliculas).


gustaPorGenero(Persona, Genero, Pelicula):-gusta(Persona, Pelicula), 
    genero(Pelicula, Genero).