# Postwork Sesión 7.

#### Resultados

Utilizando el manejador de BDD _Mongodb Compass_ (previamente instalado), deberás de realizar las siguientes acciones: 

- 1 Alojar el fichero  `data.csv` en una base de datos llamada `match_games`, nombrando al `collection` como `match`

![tabla 7_1](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%207.1.png "tabla 7_1")

- 2 Una vez hecho esto, realizar un `count` para conocer el número de registros que se tiene en la base

- 3 Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

![Tabla 7_3](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%207.3.png "Tabla 7_3")

No existe el registro porque el csv empieza en 2017, sin embargo la consulta correcta se muestra a continuación, buscando en google encontré  que ese día el Madrid aplastó al Rayo Vallecano por 10-2

```r
conexion$find(query = '{"$and":[{"Date":"2015-12-20"},{"HomeTeam":"Real Madrid"}]}')
```
Para solucionar esto se agregó el dataset de la temporada 2015-2016, obteniendo una base de datos con 1520 registros:

![Tabla 7_4](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%207.4.png "Tabla 7_4")

- 4 Agrega el dataset de `mtcars` a la misma BDD

- 5 Por último, no olvides cerrar la conexión con la BDD
 
