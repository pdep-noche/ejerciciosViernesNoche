psicosis :: UnaPelicula
psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer :: UnaPelicula
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos"
elSaborDeLasCervezas :: UnaPelicula
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas"  "Drama" 95 "Iran"
lasTortugasTambienVuelan :: UnaPelicula
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran"
juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer] 60

sofia = Usuario "sofia" "basica" 25 "Argentina" (replicate 25 elSaborDeLasCervezas) 70

usuarios :: [UnUsuario]
usuarios = [ juan, sofia]

peliculasEmpresa :: [UnaPelicula]
peliculasEmpresa = [psicosis, perfumeDeMujer, elSaborDeLasCervezas, lasTortugasTambienVuelan]

data UnaPelicula = Pelicula { nombreP :: String, generoP :: String, duracionP :: Int, 
            origenP :: String } deriving (Show, Eq)

data UnUsuario = Usuario { nombre :: String, categoria :: String, edad ::Int, 
                     paisResidencia :: String, 
                     peliculas :: [UnaPelicula], nivelSalud :: Int } deriving Show

-- 2
ver :: UnaPelicula -> UnUsuario -> UnUsuario
ver pelicula usuario = usuario { peliculas = (peliculas usuario) ++ [pelicula] }

--3
usuariosFieles :: [UnUsuario] -> [UnUsuario]
usuariosFieles usuarios = map cumpleCondiciones usuarios

cumpleCondiciones :: UnUsuario -> UnUsuario
cumpleCondiciones unUsuario | esUsuarioFiel unUsuario = subirCategoria unUsuario
                             | otherwise = unUsuario

subirCategoria:: UnUsuario -> UnUsuario
subirCategoria usuario = usuario { categoria = (cambiarCategoria . categoria) usuario }

cambiarCategoria :: String -> String
cambiarCategoria "basica" = "estandar"
cambiarCategoria _  = "premium"

esUsuarioFiel :: UnUsuario -> Bool
esUsuarioFiel usuario = ((>20).length.peliculasQueNoSeanDe "Estados Unidos". peliculas) usuario

peliculasQueNoSeanDe pais peliculas = filter ((pais /=).origenP) peliculas

--4
type Criterio = UnaPelicula -> Bool

teQuedasteCorto :: Criterio
teQuedasteCorto unaPelicula = (<35).duracionP $ unaPelicula

cuestionDeGenero :: [String] -> Criterio
cuestionDeGenero generos pelicula = any (\genero -> genero == generoP pelicula) generos

cuestionDeGenero' generos pelicula = elem (generoP pelicula) generos


deDondeSaliste :: String -> Criterio
deDondeSaliste origen pelicula = (== origen). origenP  $ pelicula

vaPorEseLado :: (Eq a) => UnaPelicula -> (UnaPelicula -> a)  -> Criterio
vaPorEseLado pelicula f otraPelicula = (f pelicula) == (f otraPelicula)

-- 5
peliculasQueCumplen :: UnUsuario -> [Criterio] ->  [UnaPelicula]
peliculasQueCumplen usuario criterios = take 3 . filter (esPeliculaRecomendablePara usuario criterios) $ peliculasEmpresa

esPeliculaRecomendablePara  :: UnUsuario ->  [Criterio] -> UnaPelicula -> Bool
esPeliculaRecomendablePara usuario criterios pelicula = ((not.vio pelicula) usuario) && (all (\f -> f pelicula) criterios)


vio pelicula usuario = elem pelicula (peliculas usuario)

{-   
peliculasQueCumplen juan [deDondeSaliste "Iran", cuestionDeGenero ["Drama", "Comedia"], (not.teQuedasteCorto)]
=> [Pelicula {nombreP = "El sabor de las cervezas", generoP = "Drama", duracionP = 95, origenP = "Iran"},Pelicula {nombreP = "Las tortugas tambi\233n vuelan", generoP = "Drama", duracionP = 103, origenP = "Iran"}]
-}

{-
peliculasQueCumplen sofia [deDondeSaliste "Iran", cuestionDeGenero ["Drama", "Comedia"], (not.teQuedasteCorto)]
=> [Pelicula {nombreP = "Las tortugas tambi\233n vuelan", generoP = "Drama", duracionP = 103, origenP = "Iran"}]
-}
-- Segunda Parte
-- 1
data UnCapitulo = Capitulo {nombreS :: String, generoS :: String, duracionS :: Int, 
                               origenS :: String, afecta :: (UnUsuario -> UnUsuario) }


-- 2
consumen :: UnUsuario -> UnCapitulo -> UnUsuario
consumen usuario capitulo = (afecta capitulo) usuario

--3
capituloI= Capitulo "Dr House - Piloto" "Drama" 34 "Estados Unidos" (\usuario -> usuario {nivelSalud = (nivelSalud usuario) - 20})

capituloII = Capitulo "Dr House - Piloto" "Drama" 34 "Estados Unidos" (\usuario -> usuario {nivelSalud = (nivelSalud usuario) `div` 2})

serie :: [UnCapitulo]
serie = [capituloI, capituloII]

--4
maraton :: UnUsuario  -> [UnCapitulo] -> UnUsuario
maraton usuario capitulos = foldl  consumen   usuario  capitulos 

{-
   maraton juan serie
=> Usuario {nombre = "juan", categoria = "estandar", edad = 23, paisResidencia = "Argentina", peliculas = [Pelicula {nombreP = "Perfume de Mujer", generoP = "Drama", duracionP = 150, origenP = "Estados Unidos"}], nivelSalud = 20}
-}

-- 6
{-
   maraton juan ((take 4 . cycle) serie)
=> Usuario {nombre = "juan", categoria = "estandar", edad = 23, paisResidencia = "Argentina", peliculas = [Pelicula {nombreP = "Perfume de Mujer", generoP = "Drama", duracionP = 150, origenP = "Estados Unidos"}], nivelSalud = 0}

maraton juan ((take 2 . cycle) serie)
=> Usuario {nombre = "juan", categoria = "estandar", edad = 23, paisResidencia = "Argentina", peliculas = [Pelicula {nombreP = "Perfume de Mujer", generoP = "Drama", duracionP = 150, origenP = "Estados Unidos"}], nivelSalud = 20}
-}