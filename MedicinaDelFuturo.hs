data Animal= Raton {nombre :: String, edad :: Float, peso :: Float,
 enfermedades :: [String]} deriving Show
-- Ejemplo de raton
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]
-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]

--  punto 1
modificarEdad f raton = raton { edad = f . edad $ raton}

modificarNombre f raton = raton { nombre = f.nombre $ raton }


modificarPeso f raton = raton { peso = f.peso $ raton }

modificarEnfermedades f raton = raton { enfermedades = f.enfermedades $ raton}

-- Punto 2
-- a
type Hierba = Animal -> Animal
hierbaBuena :: Hierba
hierbaBuena raton = modificarEdad sqrt raton

-- b
hierbaVerde :: String -> Hierba
hierbaVerde unaEnfermedad raton = modificarEnfermedades (filter (/= unaEnfermedad)) raton

-- c
alcachofa :: Hierba
alcachofa raton = modificarPeso adelgazar raton


adelgazar :: Float -> Float
adelgazar peso | peso > 2 = peso * 0.9
                | otherwise = peso * 0.95
-- d
hierbaMagica :: Hierba
hierbaMagica raton = modificarEdad (0*).modificarEnfermedades (const []) $ raton

--- Punto 3
medicamento :: [Hierba] -> Animal -> Animal
medicamento hierbas raton = foldl (\unRaton unaHierba -> unaHierba unRaton) raton  hierbas   

antiAge :: Animal -> Animal
antiAge raton  =  medicamento (replicate 3 hierbaBuena ++ [alcachofa]) raton

reduceFatFast :: Int -> Animal -> Animal
reduceFatFast potencia raton = medicamento ([hierbaVerde "obesidad"] ++ replicate potencia alcachofa) raton

hierbaMilagrosa :: Animal -> Animal
hierbaMilagrosa raton = medicamento (map hierbaVerde enfermedadesInfecciosas)  raton

{- Punto 4     a -} 
cantidadIdeal :: (Int ->Bool) -> Int
cantidadIdeal f = (head.filter f) [1..]

{- Punto 4  b -} 
estanMejoresQueNunca :: [Animal] -> (Animal -> Animal) -> Bool
estanMejoresQueNunca animales unMedicamento = all ((<1).peso.unMedicamento) animales