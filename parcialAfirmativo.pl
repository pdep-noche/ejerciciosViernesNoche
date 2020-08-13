%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

%Las ubicaciones que existen son las siguientes:
ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%Por último, se sabe quién es jefe de quién:
%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).

% 1
agente(Agente):- tarea(Agente, _, _).
frecuenta(Agente, Ubicacion):- tarea(Agente, _, Ubicacion).
frecuenta(Agente, buenosAires):- agente(Agente).
frecuenta(vega, quilmes).
frecuenta(Agente, marDelPlata):- tarea(Agente, vigilar(Negocios), _), 
    	member(alfajores, Negocios).

%2
inaccesible(Lugar):- ubicacion(Lugar), 
    not(frecuenta(_, Lugar)).

%3
afincado(Agente):- tarea(Agente, _, Ubicacion), 
    forall(tarea(Agente, _ , OtraUbicacion), igual(Ubicacion, OtraUbicacion)).

igual(Lugar, Lugar).

%4
cadenaDeMando([_]).
cadenaDeMando([Jefe, Subor| Resto]):- jefe(Jefe, Subor), 
    cadenaDeMando([Subor|Resto]).


%5
agentePremiado(Agente):-puntaje(Agente, Puntaje), 
    forall(puntaje(_, OtroPuntaje), Puntaje >= OtroPuntaje).

puntaje(Agente, PuntajeTotal):- agente(Agente), 
    findall(Puntaje, puntajeTarea(Agente, Puntaje), ListaPuntajes), 
    sumlist(ListaPuntajes, PuntajeTotal).


puntajeTarea(Agente, Puntaje):-tarea(Agente, Tarea, _), 
    cantPuntosPorTarea(Tarea, Puntaje).

%Predicado Polimorfico
cantPuntosPorTarea(vigilar(Negocios), Total):- length(Negocios, Cantidad), 
    Total is Cantidad * 5.
cantPuntosPorTarea(ingerir(_, Tamanio, Cantidad), Total):-unidades(Tamanio, Cantidad, Unidades), 
    Total is Unidades * (-10).
cantPuntosPorTarea(apresar(_, Recompensa), Total):- Total is Recompensa / 2.
cantPuntosPorTarea(asustosInternos(AgenteInvestigado), Total):- puntaje(AgenteInvestigado, Puntos), 
    Total is Puntos *2.

unidades(Tamanio, Cantidad, Unidades):- Unidades is Tamanio * Cantidad.