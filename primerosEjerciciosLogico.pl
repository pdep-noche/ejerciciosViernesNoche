
mortal(Persona):-humano(Persona).

humano(socrates).
humano(platon).

hablaIdioma(juan, español). 
hablaIdioma(juan, ingles). 
hablaIdioma(juan, italiano). 
hablaIdioma(marcela, español). 
hablaIdioma(hernan, español).
hablaIdioma(hernan, aleman).

seComunican(Persona,OtraPersona):-hablaIdioma(Persona,Idioma), hablaIdioma(OtraPersona,Idioma), Persona \= OtraPersona.

viveEn(nora, almagro).
viveEn(luis, caballito).
viveEn(ana, lugano). 
estaEn(lugano, campus). 
estaEn(almagro, medrano).
viajaEnAuto(nora). 
viajaEnAuto(matias).

llegaRapido(Persona,Lugar):-viveEn(Persona, Barrio),estaEn(Barrio, Lugar). 
llegaRapido(Persona, Lugar):- viajaEnAuto(Persona),estaEn(_, Lugar).

curso(julia, fisicaI).
curso(emilio, inglesII).
curso(elizabeth, quimica).
curso(pedro, economia).
aprobo(emilio, inglesII).
aprobo(elizabeth, quimica).

desaprobo(Persona, Materia):- curso(Persona, Materia), not(aprobo(Persona, Materia)).

contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(ariel, ford).
trabajoEn(julio, acme).
honesto(roque).
ingeniero(ana).
ingeniero(ariel).
habla(ana,ingles).
habla(ana,frances).
habla(roque,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(Persona):- joven(Persona), contador(Persona).
ambicioso(julio).
tieneExperiencia(Persona):- trabajoEn(Persona, _).
esProfesional(Persona):-contador(Persona).
esProfesional(Persona):-abogado(Persona).
esProfesional(Persona):-ingeniero(Persona).
puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria, Persona):- contador(Persona), honesto(Persona).
puedeAndar(ventas, Persona):- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):- abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona):- esProfesional(Persona), cumpleCondiciones(Persona).
cumpleCondiciones(Persona):- joven(Persona).
cumpleCondiciones(Persona):-trabajoEn(Persona, omni).

madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(Hermano, OtroHermano):- mismaMadre(Hermano, OtroHermano), mismoPadre(Hermano, OtroHermano).

mismaMadre(Persona, OtraPersona):-madre(Madre, Persona), madre(Madre, OtraPersona), Persona \= OtraPersona.

mismoPadre(Persona, OtraPersona):- padre(Padre, Persona), padre(Padre, OtraPersona), Persona \= OtraPersona.


medioHermano(Persona, OtraPersona):-mismaMadre(Persona, OtraPersona), not(hermano(Persona, OtraPersona)).
medioHermano(Persona, OtraPersona):-mismoPadre(Persona, OtraPersona), not(hermano(Persona, OtraPersona)).

hijoUnico(Persona):-hijo(Persona, _), not(hermano(Persona, _)), not(medioHermano(Persona, _)).

hijo(Persona, Progenitor):-madre(Progenitor, Persona).
hijo(Persona, Progenitor):-padre(Progenitor, Persona).

tio(Tio, Sobrino):- hermano(Tio, Progenitor), hijo(Sobrino, Progenitor).