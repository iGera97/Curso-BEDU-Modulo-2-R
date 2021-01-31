# Postwork Sesión 6.

#### Resultados

Importa el conjunto de datos match.data.csv a `R` y realice lo siguiente:

1. Agrega una nueva columna `sumagoles` que contenga la suma de goles por partido.

![Tabla6_1](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%206.1.png "Tabla6_1")

2. Obtén el promedio por mes de la suma de goles.

```r
(prom <- aggregate(sumagoles~date,FUN =mean,data = futbol))#agrupacion de medias por mes
```

3. Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.

![Tabla 6_3](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%206.3.png "Tabla 6_3")

4. Grafica la serie de tiempo.

![Tabla 6_4](https://github.com/iGera97/Curso-BEDU-Modulo-2-R/blob/main/Screenshots/tabla%206.4.png "Tabla 6_4")
