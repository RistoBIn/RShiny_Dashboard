library(shiny)
library(shinydashboard)
library(dplyr)
library(timevis)
library(tidyverse)
library(lubridate)
library(ggplot2)

termine  <- readRDS('./termine.RDS')

by_modality <- termine %>% 
  group_by(Modality) %>% 
  summarise(count=n()) %>% 
  mutate(id=c(1:4))

mergedata <- merge(termine, by_modality, all=TRUE) %>% 
  mutate(Termin_end = Termin + minutes(30) + (str_count(Bez, "&")* minutes(10)))    # edit MG

mergedata$period <- as.Date(mergedata$Termin)

myfunc <- function(inputdate) {
  per_day <- filter(mergedata, period >= inputdate & period <= inputdate)
  return(per_day)
}

server <- function(input, output, session) {
  observeEvent(input$date, {
    js$pageCol(input$date)
  })
  
  output$timeline <- renderTimevis(
    timevis(data = data.frame(
      content = c(myfunc(input$date)[['Bez']]),
      start   = c(myfunc(input$date)[['Termin']]),
      end   = c(myfunc(input$date)[['Termin_end']]),                           # edit MG
      group = c(myfunc(input$date)[['id']])),
      groups = data.frame(id = 1:4, content = c(by_modality[['Modality']]))
    )
  )
  
  output$plot1 <- renderPlot({
    termine %>% group_by(day = as.Date(Termin), ArztID, Modality) %>% count() %>% 
      filter(day == input$date) %>% 
      ggplot(aes(x = ArztID, y = n, fill = Modality)) +
      geom_col()
  })
  
  output$plot2 <- renderPlot({
    termine %>% group_by(day = as.Date(Termin), ArztID, Modality) %>% count() %>% 
      filter(day == input$date) %>% 
      ggplot(aes(x = ArztID, y = n, fill = Modality)) +
      geom_col()
  })
  
  
  
}