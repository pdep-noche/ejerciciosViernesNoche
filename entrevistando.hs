data Postulante = UnPostulante {nombre :: String, edad :: Int, remuneracion :: Float, conocimientos :: [String]} |
                     Estudiante {legajo :: String, conocimientos :: [String]} deriving Show 

pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok", "C"]

tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

julia = Estudiante "18943221-1" ["Haskell", "Java", "Prolog"]

postulantes :: [Postulante]
postulantes = [pepe, tito, julia]

type Nombre = String
data Puesto = UnPuesto {puesto:: String, conocimientoRequeridos :: [String]} deriving Show
jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]
chePibe = UnPuesto "cadete" ["ir al banco"]
 
apellidoDueno:: Nombre
apellidoDueno = "Gonzalez"

----- 1 ------
-- a
type Requisito = Postulante -> Bool

tieneConocimientos  :: Puesto -> Requisito
tieneConocimientos unPuesto unPostulante = all (\unConoReque -> elem unConoReque (conocimientos unPostulante)). conocimientoRequeridos $ unPuesto

-- b
edadAceptable  :: Int -> Int ->Requisito
edadAceptable edadMin edadMax unPostulante =  ((>=edadMin).edad) unPostulante && ((<=edadMax).edad) unPostulante

-- c
sinArreglo :: Requisito
sinArreglo unPostulante = not.(apellidoDueno ==).last.words.nombre $ unPostulante

--2
cumpleRequisitos :: [Postulante] -> [Requisito] -> [Postulante]
cumpleRequisitos conjPostulantes requisitos = filter (cumpleTodos requisitos)  conjPostulantes

cumpleTodos :: [Requisito] -> Postulante -> Bool
cumpleTodos conjRequisitos unPostulante = all (\unRequisito -> unRequisito unPostulante) conjRequisitos

--b
{-
cumpleRequisitos [pepe, tito] [tieneConocimientos jefe, edadAceptable 30 40, sinArreglo, (\unPostulante -> not.elem "repetir logica".conocimientos $ unPostulante) 
-}

-- 3
-- a
actualizarPostulantes :: [Postulante] -> [Postulante] 
actualizarPostulantes conjPostulantes = [ (aumentarSueldo 27 . incrementarEdad) unPostulante| unPostulante <- conjPostulantes]

incrementarEdad :: Postulante -> Postulante
incrementarEdad unPostulante = unPostulante { edad = edad unPostulante + 1 }

aumentarSueldo :: Float -> Postulante -> Postulante
aumentarSueldo unPorcentaje unPostulante  = unPostulante { remuneracion = remuneracion unPostulante + incremento unPorcentaje (remuneracion unPostulante) }

incremento porcentaje sueldo = (porcentaje * sueldo) / 100

{-   actualizarPostulantes [pepe, tito]
=> [UnPostulante {nombre = "Jose Perez", edad = 36, remuneracion = 19050.0, conocimientos = ["Haskell","Prolog","Wollok","C"]},UnPostulante {nombre = "Roberto Gonzalez", edad = 21, remuneracion = 15240.0, conocimientos = ["Haskell","Php"]}]
-}

-- 3 b
actualizarPostulantes' :: [Postulante] -> [Postulante]
actualizarPostulantes' postulantes = map (aumentarSueldo 27 . incrementarEdad) postulantes


capacitar :: Postulante -> String -> Postulante
capacitar (UnPostulante nom edad sueldo conocimientos) unConocimiento = (UnPostulante nom edad sueldo (agregarConocimiento unConocimiento conocimientos))
capacitar (Estudiante legajo conocimientos) unConocimiento = (Estudiante legajo (agregarConocimiento unConocimiento (init conocimientos)))

agregarConocimiento unConocimiento conocimientos = conocimientos ++ [unConocimiento]

-- 3 c
capacitacion :: Puesto -> Postulante -> Postulante
capacitacion unPuesto unPotulante = foldl capacitar unPotulante (conocimientoRequeridos unPuesto)
