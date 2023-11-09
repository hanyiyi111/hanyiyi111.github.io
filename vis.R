library(shiny)
library(ggplot2)
library(readxl)
library(tidyverse)

data_for_vis <- read_excel("data_disorder.xlsx", range = "A1:K6469") %>% 
  select(Entity, Year, `Eating disorders (%)`) %>%
  mutate(ed = as.numeric(`Eating disorders (%)`), Year = as.numeric(Year))

ui <- fluidPage(
  titlePanel("Interactive Line Graph in Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Countries", "Select a Country:", unique(data_for_vis$Entity))
    ),
    mainPanel(
      plotOutput("linePlot")
    )
  )
)
server <- function(input, output) {
  
  output$linePlot <- renderPlot({
    data_for_vis %>% filter(Entity == input$Countries) %>%
    ggplot(aes(x = Year, y = `Eating disorders (%)`)) +
      geom_line() +
      labs(title = "Line Graph by Country")
  })
}
shinyApp(ui, server)
