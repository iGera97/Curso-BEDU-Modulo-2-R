#Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
futbol<- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv")

#1Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
library(dplyr)
futbol<- mutate(futbol,sumagoles= (home.score+away.score))
head(futbol)       
str(futbol)
tail(futbol)

#2#Obtén el promedio por mes de la suma de goles.
#Para evitar problemas en la serie de tiempo se decidio mantener el formato de fecha
#$Y-%m-%d, com se iba a agrupar por meses se cambió el día de todas las fechas por 01
#con esto las fechas se limitaban a tener un mismo registro por mes
futbol <- mutate(futbol,date= (paste(substr(date,1,8),"28")))
futbol <- mutate(futbol,date= as.Date(date,"%Y-%m-%d"))
#futbol<- mutate(futbol,date= format(date,"%Y-%m"))#opcion 2
unique(futbol$date)
(prom <- aggregate(sumagoles~date,FUN =mean,data = futbol))#agrupacion de medias por mes

class(prom)
str(prom)

#3 Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
#Al existir meses sin resultados(JUN y jULIO) se decidio usar la biblioteca zoo
#esta funciona como una serie de tiempo
library(zoo)
#Filtradode fechas hasta dicembre de 2019
prom <- filter(prom,date<"2020-01-01")
tail(prom)
str(prom)
(ts.mean=zoo(prom$sumagoles, order.by=prom$date))
str(ts.mean)
tail(ts.mean)
class(ts.mean)

#4 Grafica la serie de tiempo.
plot(ts.mean, 
     main = "Goles promedio por mes LaLiga", 
     xlab = "Tiempo",ylab = "Promedio",
     sub = "Agosto 2010 - Diciembre de 2019")
start(ts.mean);end(ts.mean);frequency(ts.mean)
