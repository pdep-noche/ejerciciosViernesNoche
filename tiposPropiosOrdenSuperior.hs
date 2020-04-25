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