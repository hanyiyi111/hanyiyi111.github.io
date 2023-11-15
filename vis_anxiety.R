library(shiny)
library(ggplot2)
library(readxl)
library(tidyverse)

data_for_vis <- read_excel("data_disorder.xlsx", range = "A1:K6469") %>%
  filter(Entity == c("Central Asia", "Central Europe", "Central Europe, Eastern Europe, and Central Asia", "Central Latin America", "Central Sub-Saharan Africa", "East Aisa", "Eastern Europe", "Eastern Sub-Saharan Africa", "High SDI", "High-income", "High-income Asia Pacific", "High-middle SDI", "Latin America and Caribbean", "Low SDI", "Low-middle SDI", "Middle SDI", "North Africa and Middle East", "North America", "Oceania", "South Asia", "Southeast Aisa", "Southeast Asia, East Asia, and Oceania", "Southern Latin America", "Southern Sub-Saharan Africa", "Tropical Latin America", "Western Europe", "Western Sub-Saharan Africa", "World")) %>%
  select(Entity, Year, `Anxiety disorders (%)`) %>%
  mutate(`Anxiety disorders (%)` = as.numeric(`Anxiety disorders (%)`), Year = as.numeric(Year))

ui <- fluidPage(
  titlePanel("Percentage of Anxiety Disorders Patients Worldwide"),
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
    ggplot(aes(x = Year, y = `Anxiety disorders (%)`)) +
      geom_line() +
      labs(title = "Line Graph by Country")
  })
}

shinyApp(ui, server)
