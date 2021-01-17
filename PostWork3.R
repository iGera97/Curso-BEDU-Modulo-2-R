#1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas
#  de frecuencias relativas para estimar las siguientes probabilidades:
df.17_18 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
df.18_19 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
df.19_20 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")  

library(dplyr)
df.17_18 <- select(df.17_18,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)
df.18_19 <- select(df.18_19,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)
df.19_20 <- select(df.19_20,Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR)

df.17_18 <- mutate(df.17_18,Date = as.Date(Date, "%d/%m/%y")) 
df.18_19 <- mutate(df.18_19,Date = as.Date(Date, "%d/%m/%Y")) 
df.19_20 <- mutate(df.19_20,Date = as.Date(Date, "%d/%m/%Y")) 
data17_20 <- rbind(df.17_18,df.18_19,df.19_20)
str(data17_20)  
  
#La probabilidad (marginal) de que el equipo que juega en casa
#anote x goles (x=0,1,2,)
g.home <- data17_20$FTHG
t.home <- table(g.home)
marginal.home <- prop.table(t.home)

#La probabilidad (marginal) de que el equipo que juega como visitante
#anote y goles (y=0,1,2,)
g.away <- data17_20$FTAG
t.away <- table(g.away)
marginal.away <- prop.table(t.away)

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles
#y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
t.17_20 <- table(g.home,g.away) 
conjunta <- prop.table(t.17_20)

#2. Realiza lo siguiente:
#Un gráfico de barras para las probabilidades marginales estimadas
#del número de goles que anota el equipo de casa
library(ggplot2)
df.marginal.home <- as.data.frame(marginal.home)
ggplot(df.marginal.home,aes(x=g.home,y=Freq,fill=Freq))+
  geom_bar(stat = "identity",position ="stack",col="black")+
  ggtitle("Probabilidades marginales estimadas de anotar X goles en casa")+
  xlab("Goles a anotar")+ylab("Probabilidad de anotar")+
  labs(fill="Goles")+  scale_fill_gradientn(colours = cm.colors(9)) 

#Un gráfico de barras para las probabilidades marginales estimadas
#del número de goles que anota el equipo visitante.
df.marginal.away <- as.data.frame(marginal.away)
ggplot(df.marginal.away,aes(x=g.away,y=Freq,fill=Freq))+
  geom_bar(stat = "identity",position ="stack",col="black")+
  ggtitle("Probabilidades marginales estimadas de anotar X goles de visitate")+
  xlab("Goles a anotar")+ylab("Probabilidad de anotar")+
  labs(fill="Goles") +
  scale_fill_gradientn(colours = topo.colors(7))

#Un HeatMap para las probabilidades conjuntas estimadas de los números
#de goles que anotan el equipo de casa y el equipo visitante en un partido.
conjunta
df.conjunta <- as.data.frame(conjunta)

ggplot(df.conjunta,aes(x=g.away,y=g.home,fill=Freq))+geom_tile()+
  scale_fill_gradientn(colours = rainbow(10))+
  ggtitle("Probabilidades conjuntas de los goles que anotan el equipo local y visitante")+
  xlab("Goles equipo visitante")+ylab("Goles equipo local")+
  labs(fill="Probabilidad")

