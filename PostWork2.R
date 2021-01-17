#1. Importa los datos de soccer de las temporadas 2017/2018, 
# 2018/2019 y 2019/2020 de la primera división de la liga española a R
df.17_18 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
df.18_19 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
df.19_20 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#lista <- list(df.17_18,df.18_19,df.19_20)#opcion con lista

#2Obten una mejor idea de las características de los data frames al
#usar las funciones: str, head, View y summary
str(df.17_18);str(df.18_19);str(df.19_20)
head(df.17_18);head(df.18_19);head(df.19_20)
View(df.17_18);View(df.18_19);View(df.19_20)
summary(df.17_18);summary(df.18_19);summary(df.19_20)

#3Con la función select del paquete dplyr selecciona únicamente las columnas
#Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data 
#frames. (Hint: también puedes usar lapply).
library(dplyr)
df.17_18 <- select(df.17_18,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)
df.18_19 <- select(df.18_19,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)
df.19_20 <- select(df.19_20,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)

#lista <- lapply(lista, select,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)#opcion con lista

#4. Asegúrate de que los elementos de las columnas correspondientes de los
#nuevos data frames sean del mismo tipo. Con ayuda de la función rbind 
#forma un único data frame que contenga las seis columnas mencionadas en el
#punto 3.
df.17_18 <- mutate(df.17_18,Date = as.Date(Date, "%d/%m/%y")) 
df.18_19 <- mutate(df.18_19,Date = as.Date(Date, "%d/%m/%Y")) 
df.19_20 <- mutate(df.19_20,Date = as.Date(Date, "%d/%m/%Y")) 

dataFinal <- rbind(df.17_18,df.18_19,df.19_20)
str(dataFinal)
tail(dataFinal)

#opcion lista
'
str(lista)
lista[[1]] <- mutate(lista[[1]],Date = as.Date(Date, "%d/%m/%y")) 
lista[[2]] <- mutate(lista[[2]],Date = as.Date(Date, "%d/%m/%Y")) 
lista[[3]] <- mutate(lista[[3]],Date = as.Date(Date, "%d/%m/%Y")) 

dataFinal2 <- do.call(rbind,lista)#opcion do.call
str(dataFinal2)
tail(dataFinal2)'
