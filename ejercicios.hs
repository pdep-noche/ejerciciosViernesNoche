import Text.Show.Functions

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal  _  = False

primerLetra :: String -> Char
primerLetra palabra = head palabra

comienzaConA :: String -> Bool
comienzaConA palabra = (primerLetra palabra) == 'a'

suma :: Integer -> Integer -> Integer
suma x y = x + y

calcular :: (Integer, Integer) -> (Integer, Integer)
calcular (nro, otroNum) | even nro && odd otroNum = (doble nro, siguiente otroNum)
                         | even nro = (doble nro, otroNum)
                         | odd otroNum = (nro, siguiente otroNum)
                         | otherwise = (nro, otroNum)

doble :: Integer -> Integer
doble nro = nro *2

siguiente:: Integer -> Integer
siguiente nro = nro + 1


and' :: Bool -> Bool -> Bool
and' exp otraExp | exp = otraExp
                  | otherwise = False

and'' :: Bool -> Bool -> Bool
and'' True exp = exp
and'' _  _ = False

or' :: Bool -> Bool -> Bool
or' exp otraExp | exp = True
                 | otherwise = otraExp


or'' :: Bool -> Bool -> Bool
or'' True _ = True
or'' _ expre = expre


type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)


notaMaxima :: Alumno -> Nota
notaMaxima (_, nota1, nota2, nota3) = (max nota1. max nota2) nota3


notaMaxima' :: Alumno -> Nota
notaMaxima' (_, nota1, nota2, nota3) = (nota1 `max` nota2) `max` nota3

