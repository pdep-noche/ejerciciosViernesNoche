type Nombre = String
type Notas = [Int]
data Persona = Alumno {nombre :: Nombre, notas :: Notas}

alumnos :: [Persona]
alumnos = [juan, maria, ana, elena]

juan :: Persona
juan = Alumno "juan" [8,6]

maria :: Persona
maria = Alumno "maria" [7,9,4]

ana :: Persona
ana = Alumno "ana" [6,2,4]

elena :: Persona
elena = Alumno "elena" [7,9,8,7]

promediosAlumnos :: [Persona] -> [(Nombre, Int)]
promediosAlumnos alumnos = map (\(Alumno nombre notas) -> (nombre, promedio notas))  alumnos

promedio :: Notas -> Int
promedio notas = (sum notas) `div` (length notas) 

promediosSinAplazos :: [Notas] -> Notas
promediosSinAplazos listaNotas = map (promedio.filter (>5)) listaNotas

aprobo :: Persona -> Bool
aprobo  = all (>=6).notas

aprobaron :: [Persona] -> [Nombre]
aprobaron  = map nombre . filter aprobo

productos :: [String] -> [Int] -> [(String, Int)]
productos  = zip  

productosConZipWith :: [String] -> [Int] -> [(String, Int)]
productosConZipWith nombres precios = zipWith (\nom prec -> (nom, prec)) nombres precios

data Flor= Flor {nombreFlor :: String, aplicacion:: String, cantidadDeDemanda:: Int } deriving Show

rosa :: Flor
rosa = Flor "rosa" "decorativo" 120
jazmin :: Flor
jazmin =  Flor "jazmin" "aromatizante" 100
violeta :: Flor
violeta=  Flor "violeta" "infusión" 110
orquidea :: Flor
orquidea =  Flor "orquidea" "decorativo" 90

flores :: [Flor]
flores = [orquidea, rosa,violeta, jazmin]

maximoSegun :: (Flor -> Int ) -> [Flor] -> String
maximoSegun f listaFlores = (nombreFlor.maximaFlorSegun f) listaFlores

maximaFlorSegun :: (Flor -> Int) -> [Flor] -> Flor
maximaFlorSegun _  [x] = x
maximaFlorSegun f (x:xs) | f x >= (f . maximaFlorSegun f) xs = x
                          | otherwise = maximaFlorSegun f xs

estaOrdenada :: [Flor] -> Bool
estaOrdenada [_] = True
estaOrdenada (unaFlor:otraFlor:lista) = cantidadDeDemanda unaFlor > cantidadDeDemanda otraFlor && estaOrdenada (otraFlor:lista)