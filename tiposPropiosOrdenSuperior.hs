data Empleado = Comun {nombre:: String, sueldoBasico :: Double} |
    Jefe {nombre:: String, sueldoBasico:: Double, cantACargo ::Double}

sueldo :: Empleado -> Double
sueldo (Comun _ basico) = basico
sueldo (Jefe _ basico cantACargo) = basico + plus cantACargo

plus cantidad = 500 * cantidad

juan :: Empleado
juan = Jefe "juan" 20000 4

ana :: Empleado
ana = Comun "ana" 25000

type Nombre = String
type Azucar = Int
type Sabor = String
data Bebida = Cafe Nombre Azucar | Gaseosa Sabor Azucar

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe "capuchino" _) = True
esEnergizante (Gaseosa "pomelo" cantAzucar) = cantAzucar > 10
esEnergizante _  = False

cantidadAzucar :: Bebida -> Azucar
cantidadAzucar (Cafe _ cantidad) = cantidad
cantidadAzucar (Gaseosa _ cantidad) = cantidad

data Persona = Estudiante {nom :: String, edad :: Int} deriving Show

cumplirAños :: Persona -> Persona
cumplirAños estudiante = estudiante {edad = edad estudiante + 1}

julia :: Persona
julia = Estudiante "julia" 20

