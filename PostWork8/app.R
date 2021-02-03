#LibrerÃ­as
library(fbRanks)
library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(shinythemes)
##Sesión 8 BEDU: Módulo R | Martes 2 de Febrero de 2021
## Equipo 2: Atenea De La Cruz Brito, Gerardo Miguel Pérez Solis, Zoé Ariel García Martínez 
#Directorio
setwd("C:/...")
#Desarrollo:
#Para este postwork genera un dashboard en un solo archivo app.R, para esto realiza lo siguiente:
##1.	Ejecuta el cÃ³digo momios.R

##2.	Almacena los grÃ¡ficos resultantes en formato png
##3.	Crea un dashboard donde se muestren los resultados con 4 pestaÃ±as:
##4.	Una con las grÃ¡ficas de barras, donde en el eje de las x 
#se muestren los goles de local y visitante con un menu de selecciÃ³n, 
#con una geometria de tipo barras ademÃ¡s de hacer un facet_wrap con el equipo visitante

##5.	Realiza una pestaÃ±a donde agregues las imÃ¡genes de las grÃ¡ficas del postwork 3

##6.	En otra pestaÃ±a coloca el data table del fichero match.data.csv

##7.	Por Ãºltimo en otra pestaÃ±a agrega las imÃ¡genes de las grÃ¡ficas
#de los factores de ganancia mÃ­nimo y mÃ¡ximo

# Shinydasboard UI
ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title = "Dashboard Postwork 8 Equipo 2"),
        #Sidebar content
        dashboardSidebar(
            sidebarMenu(
                menuItem("Graficas goles", tabName = "Dashboard", icon = icon("dashboard")),
                menuItem("Prob. goles", tabName = "Prob", icon = icon("area-chart")),
                menuItem("Data Table", tabName = "Datatable", icon = icon("table")),
                menuItem("Factores de ganancia", tabName = "Factores", icon = icon("area-chart"))
            )
        ),
        #Body content      
        dashboardBody(
            tabItems(
                #First Tab
                tabItem(tabName = "Dashboard",
                        fluidRow(
                            titlePanel("Histograma"), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = c("home.score", "away.score")),
                            plotOutput("plot1")
                        )
                ),
                #Second Tab
                tabItem(tabName = "Prob", 
                        fluidRow(
                            titlePanel(h3("Graficos de probabilidades de goles temporadas 17-20")),
                            h3("Grafico de probabilidades marginales goles Locales"),
                            img(src = "Grafico 3.1.png") ,
                            h3("Grafico de probabilidades marginales goles Visitantes"),
                            img(src = "Grafico 3.2.png") ,
                            h3("Grafico de probabilidades conjuntas"),
                            img(src = "Grafico 3.3.png")
                        )
                ),
                #Third Tab
                tabItem(tabName = "Datatable",
                        fluidRow(        
                            titlePanel(h3("Tabla completa")),
                            dataTableOutput ("Match_Data")
                        )
                ), 
                #Fourth Tab
                tabItem(tabName = "Factores",
                        fluidRow(
                            titlePanel(h3("Factores de ganacia")),
                            h3("Factor de ganancia Máximo"),
                            img(src ="graficomax.png"),
                            h3("Factor de ganancia Promedio"),
                            img( src = "graficomin.png")
                        )
                )
            )
        )
    )
)

#######################################################################


#Server
server <- function(input, output) {
    output$plot1 <- renderPlot({
        data <-  read.csv("match.data.csv", header = T)
        
        data <- mutate(data, FTR = ifelse(home.score > away.score, "H", ifelse(home.score < away.score, "A", "D")))
        x <- data[,input$x]
        
        data %>% ggplot(aes(x, fill = FTR)) + 
            geom_bar() + 
            facet_wrap("away.team", labeller = "label_both",scales = "free") +
            labs(x =input$x, y = "Goles") + 
            ylim(0,50)
    })
    
    #Data Table
    output$Match_Data <- renderDataTable( {read.csv("match.data.csv")}, 
                                         options = list(aLengthMenu = c(10,25,50),
                                                        iDisplayLength = 10)
    )
    
}

shinyApp(ui, server)
