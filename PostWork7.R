#Postwork 7
#install.packages("mongolite")
library(mongolite)
#1. Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al 
#collection como match
# Conexion al servidor
url_path = 'mongodb+srv://<username here>:<password here>!@<cluster url>/admin'

conexion <- mongo(collection = "match", db = "match_games", 
                  url = url_path, 
                  verbose = TRUE)

print(conexion)
if(conexion$count() > 0) conexion$drop()
conexion$insert(read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv"))

#2. Una vez hecho esto, realizar un count para conocer el n�mero de 
#registros que se tienen la base
conexion$count()

#3. Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para
#conocer el n�mero de goles que meti� el Real Madrid el 20 de diciembre de 2015 y 
#contra que equipo jug�, �perdi� � fue goleada?
conexion$find(query = '{"$and":[{"Date":"2015-12-20"},{"HomeTeam":"Real Madrid"}]}')
#No existe el registro porque el csv empieza en 2017, sin embargo la anterior linea ser�a
#la consulta correcta, buscando en google encontr�  que ese d�a el Madrid aplast� al
#Rayo Vallecano por 10-2

#4 Agrega el dataset de mtcars a la misma BDD
conexion <- mongo(collection = "mtcars", db = "match_games", 
                  url = url_path, 
                  verbose = TRUE)

conexion$insert(mtcars)
conexion$count()
#5. Por �ltimo, no olvides cerrar la conexi�n con la BDD
rm(conexion)