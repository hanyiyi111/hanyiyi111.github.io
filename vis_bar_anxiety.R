library(shiny)
library(ggplot2)
library(readxl)
library(tidyverse)
library(shinydashboard)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    data_for_vis <- read_excel("data_disorder.xlsx", range = "A1:K6469") %>%
      filter(Year == 2017) %>%
      select(Entity, Year, `Alcohol use disorders (%)`) %>%
      mutate(`Alcohol use disorders (%)` = as.numeric(`Alcohol use disorders (%)`), Year = as.numeric(Year))
    
    
    #Plot
    barplot(data_for_vis$Entity)
    
  })
  
}

ui <- basicPage(
  h1("R Shiny Bar Plot"),
  plotOutput("plot")
  
)

shinyApp(ui = ui, server = server)