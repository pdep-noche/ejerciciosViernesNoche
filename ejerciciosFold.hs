cantidadDeElementosFoldl lista = foldl contar 0   lista

contar sem _ = sem + 1

cantidadDeElementosLambda lista = foldl (\sem _ -> sem + 1) 0 lista

cantidadDeElementosFoldr lista = foldr (\_ sem -> sem + 1)  0 lista


masGastadorFoldl (cab:cola) = foldl maximo cab cola

maximo persona otraPersona | snd persona > snd otraPersona = persona
                           | otherwise = otraPersona


masGastadorFoldr (cab:cola) = foldr maximo  cab cola


montoFoldl lista = foldl (\sem (_,gasto) -> sem + gasto) 0 lista

montoFoldr lista = foldr (\(_, gasto) sem -> gasto + sem) 0 lista


type Nombre  = String
type InversionInicial = Int
type Profesionales = [String]

data  Proyecto = Proy {nombre:: Nombre, inversionInicial::  InversionInicial, profesionales:: Profesionales} deriving Show

proyectos :: [Proyecto]
proyectos = [Proy "red social de arte"  20000 ["ing. en sistemas", "contador"], Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"], Proy "ventaChurros" 1000 ["cocinero"] ]

--- Usando foldl
proyectoMaximoSegun criterio (unProyecto:proyectos) =  foldl (maximoProyecto criterio)  unProyecto  proyectos

maximoProyecto criterio unProyecto otroProyecto | criterio unProyecto > criterio otroProyecto  = unProyecto
                                                | otherwise = otroProyecto

{- a
Según Inversión Inicial
proyectoMaximoSegun inversionInicial proyectos
Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}
-}

{- b
El nro de profesionales.
proyectoMaximoSegun (length.profesionales) proyectos
Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]}
-}

{- c
 proyectoMaximoSegun (length.words.nombre) proyectos
=> Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}
-}

---Usando foldr
proyectoMaximoSegunFoldr criterio (unProyecto:proyectos) =  foldr (maximoProyecto criterio)  unProyecto  proyectos

{- Punto a
   proyectoMaximoSegunFoldr inversionInicial proyectos
=> Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

Punto b
proyectoMaximoSegunFoldr (length.profesionales) proyectos
=> Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]}

Punto c
proyectoMaximoSegunFoldr (length.words.nombre) proyectos
=> Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]} 
-}