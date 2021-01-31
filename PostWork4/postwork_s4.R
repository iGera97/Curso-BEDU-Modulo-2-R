futbol <- read.csv("data17_20.csv")

str(futbol)
library(dplyr)

#probabilidad marginal en casa
gcasa <- table(futbol$FTHG)
ftab_casa <- prop.table(gcasa)

df_casa <- as.data.frame(ftab_casa)
df_casa <- rename(df_casa, Goles = Var1, Probabilidad = Freq)

#probabilidad marginal fuera de casa
gfuera <- table(futbol$FTAG)
ftab_fuera <- prop.table(gfuera)

df_fuera <- as.data.frame(ftab_fuera)
df_fuera <- rename(df_fuera, Goles = Var1, Probabilidad = Freq)

#proba conjunta
gconj <- xtabs(~FTAG+FTHG, futbol)
ftab_gconj <- gconj/length(futbol$FTHG)
class(gconj)

#1 Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto
#de las probabilidades marginales correspondientes los elementos deben de ser del tipo:
#Conj_ij/(Casa_i*Fuera_j)

ftab_gconj[,9]/(ftab_fuera) #multiplico 

#puedo generar una matrix que tenga las dimensiones de ftab_gconj o puedo reescribirla

mc <- ftab_gconj #reescribo la matriz
class(mc)
#multiplico por columna y guardo
for (i in 1:9){
  mc[,i] <- ftab_gconj[,i]/ftab_fuera
  print(mc[,i])
} 

#multiplico por fila y guardo  
for (i in 1:7){
  mc[i,] <- mc[i,]/ftab_casa
}

mc # <- ahora tengo la tabla de cocientes

#Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos
#en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la
#cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece 
#razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 
#(en tal caso tendríamos independencia de las variables aleatorias X y Y).

#podría hacer un boot sobre el data frame, pero eso sería muy tardado de analizar...

#haré un bootstrap sobre un melt de las probabilidades:
str(mc)
library(reshape2)

mc_melt <- melt(mc)
class(mc_melt) # -> es un df, entonces puedo usar bootstrap:

library(rsample)
mc.boot <- bootstraps(mc_melt, times = 10)

class(mc.boot$splits[[1]])

meanv <- c()

for(i in 1:100000){
  meanv[i] = mean(sample(mc_melt$value, length(mc_melt$value), replace = TRUE))
}

head(meanv)

library(ggplot2)

ggplot() + 
geom_histogram(bins = 50) + 
aes(meanv)+
geom_vline(xintercept = mean(meanv)) +
ggtitle('Histograma de la distribución de las medias en el Bootstrap') +
xlab("Promedio de los cocientes Bootstrap") 

#notemos que en este caso el promedio para las medias de la distribución de cocientes es menor a 1!!!