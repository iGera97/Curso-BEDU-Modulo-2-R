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

#2. Una vez hecho esto, realizar un count para conocer el número de 
#registros que se tienen la base
conexion$count()

#3. Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para
#conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y 
#contra que equipo jugó, ¿perdió ó fue goleada?
conexion$find(query = '{"$and":[{"Date":"2015-12-20"},{"HomeTeam":"Real Madrid"}]}')
#No existe el registro porque el csv empieza en 2017, sin embargo la anterior linea sería
#la consulta correcta, buscando en google encontré  que ese día el Madrid aplastó al
#Rayo Vallecano por 10-2

#4 Agrega el dataset de mtcars a la misma BDD
conexion <- mongo(collection = "mtcars", db = "match_games", 
                  url = url_path, 
                  verbose = TRUE)

conexion$insert(mtcars)
conexion$count()
#5. Por último, no olvides cerrar la conexión con la BDD
rm(conexion)
