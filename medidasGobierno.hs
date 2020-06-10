-- Medidas
type Bien = (String,Float)
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float, cantidadDeHijos :: Int, bienes :: [Bien] } deriving Show

homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]

type Ciudad = [Ciudadano]
springfield :: Ciudad
springfield = [homero, burns, frink, krabappel]

diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio unaCiudad = (patrimonio.obtenerCiudadanoSegun mayor) unaCiudad - (patrimonio.obtenerCiudadanoSegun menor) unaCiudad


patrimonio :: Ciudadano -> Float
patrimonio unCiudadano = foldl (\acum (_, monto) ->  acum + monto)  (sueldo unCiudadano) (bienes unCiudadano)

obtenerCiudadanoSegun f (unCiudadano:ciudadanos) =  foldl f unCiudadano ciudadanos 


mayor unCiudadano otroCiudadano | patrimonio unCiudadano > patrimonio otroCiudadano = unCiudadano
                                | otherwise = otroCiudadano


menor unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                 | otherwise = otroCiudadano
