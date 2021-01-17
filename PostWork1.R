#1. Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R
df.liga <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#2. Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los
#números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados
#por los equipos que jugaron como visitante (FTAG)
#SEPARAMOS EN DOS VECTORES DIFERENTES
goles.local <- df.liga$FTHG#extraccion de la columna de goles locales
goles.visitante <- df.liga$FTAG#extraccion de la columna de goles visitantes

#3. Elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
#HACEMOS UNA SOLA TABLA DE FRECUENCIA CON AMBOS DATOS
tabla.union <- table(goles.local,goles.visitante)#agrupamiento en una sola tabla

#TABLA DE FRECUENCIA POR VECTOR(MARGINAL)
group.local.x <- table(goles.local) #agrupamiento individual separado 
#margin.table(tabla.union,1)#lo mismo que arriba 1 MARGEN DE FILAS
group.visitante.y <- table(goles.visitante) #agrupamiento individual separado
#margin.table(tabla.union,2)#lo mismo que arriba 2 MARGEN DE COLUMNAS

#CALCULO DE PROBABILIDADES  MARGINALES
#NOTA: prob.table() margin NULL GLOBALES, 1 POR FILA, 2 POR COLUMNA
#probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
marginal.local <- prop.table(group.local.x) #probabilidad marginal de locales
#probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
marginal.visitante <- prop.table(group.visitante.y) #probabilidad marginal de visitantes

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo
#que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
prob.conjunta <- prop.table(tabla.union,NULL) #probabilidad conjunta

addmargins(prob.conjunta,1)#1 agrega total de las columnas, 2 total filas

