Nombre y apellido 
Integrante 1: Facundo Laprovitta
Integrante 2: Martina Gabriela Sánchez Garcías
Integrante 3: Miqueas Gigena DePaul
Integrante 4: José Ignacio Tomé


Descripción ejercicio 1: Imagen de una Mazda Miata en una ruta desertica de dia. Con un cartel al fondo donde esta inscripto ODC en ASCII a Hexadecimal.


Descripción ejercicio 2:


Justificación instrucciones ARMv8:
-csel: Utilizamos la instruccion csel ya que simplifica y reduce la cantidad de codigo para decidir el valor de un regristro dependiendo de una condicion.
       Esto mismo se pudo haber hecho con el uso de cmp, b.cond y etiquetas sin embargo con csel reducimos el uso de 3/4 lineas de codigo a solo una.

-bfi:  Utilizamos la instruccion bfi para la manipulacion de registros utilizando otros registros ya que movz y movk de LEGv8 solo funcionan con inmediatos.
       Y en nuestro caso necesitabamos poder usar registros para poder mover todas los componentes del auto de manera pareja.

