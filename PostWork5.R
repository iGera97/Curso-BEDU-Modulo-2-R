#1 
df.17_18 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
df.18_19 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
df.19_20 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")  
str(df.18_19)
library(dplyr)
df.17_18 <- select(df.17_18,Date, HomeTeam, FTHG, AwayTeam, FTAG)
df.18_19 <- select(df.18_19,Date, HomeTeam, FTHG, AwayTeam, FTAG)
df.19_20 <- select(df.19_20,Date, HomeTeam, FTHG, AwayTeam, FTAG)

df.17_18 <- mutate(df.17_18,Date = as.Date(Date, "%d/%m/%y")) 
df.18_19 <- mutate(df.18_19,Date = as.Date(Date, "%d/%m/%Y")) 
df.19_20 <- mutate(df.19_20,Date = as.Date(Date, "%d/%m/%Y")) 
SmallData <- rbind(df.17_18,df.18_19,df.19_20)
colnames(SmallData) <- c("date", "home.team", "home.score", "away.team" ,"away.score")
str(SmallData)  
write.csv(SmallData,file = "soccer.csv",row.names = F)

#2
#install.packages("fbRanks")
library(fbRanks)
listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv",date.format = "%Y-%m-%d")
str(listasoccer)
(anotaciones <- listasoccer$scores)
(equipos <- listasoccer$teams)

#3
(fechas <-unique(listasoccer$scores$date))
summary(fechas)
tail(listasoccer$scores)
(n <- length(fechas))
ranking <- rank.teams(scores = anotaciones,teams=equipos,
                      max.date = fechas[n-1],min.date = fechas[1],
                      date.format = "%Y-%m-%d")

#4
predicciones <- predict(ranking,date = fechas[n],max.date = fechas[n],min.date = fechas[1])
