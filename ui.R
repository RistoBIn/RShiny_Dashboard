library(shiny)
library(shinydashboard)
library(timevis)
library(shinyjs)

jsCode <- 'shinyjs.pageCol = function(params){ 
  setTimeout(function(){ 
      var tooltips = document.querySelectorAll(".vis-item-content");
      Array.prototype.forEach.call(tooltips, function(h){
      
        var content = h.innerHTML;
        h.addEventListener("mouseover", function( event ) {
          event.target.parentElement.parentElement.style.width = "auto";
          event.target.parentElement.parentElement.style.zIndex = 2;
        })
        h.addEventListener("mouseout", function( event ) {
          event.target.parentElement.parentElement.style.width = "";
          event.target.parentElement.parentElement.style.zIndex = "";
        
        })
        h.innerHTML += "<span class="+"tooltiptext"+">"+content+"</span>"
      
      });
    
    
  }, 5000);}'

ui <- dashboardPage(
  
  
  dashboardHeader(title = "My dashboard"),
  
  ## Sidebar content
  dashboardSidebar(
    
    sidebarMenu(
      useShinyjs(),
      extendShinyjs(text = jsCode),
      dateInput('date',
                label = 'Date input',
                value = Sys.Date()
      )
    )
  ),
  
  dashboardBody(
       tags$head(includeCSS("./style.css")),
       
       fluidRow(
          box(
              title = "Plot1", 
              status = "primary", 
              solidHeader = TRUE, 
              collapsible = TRUE,
              plotOutput("plot1", height= 250)
          ),
          
          box(
            title = "Plot2", 
            status = "primary", 
            solidHeader = TRUE,
            collapsible = TRUE,
            plotOutput("plot2",  height= 250)
          )
        ),
       fluidRow(
          box(
            width = 12,
            title = "Timeline", 
            status = "primary", 
            solidHeader = TRUE, 
            collapsible = TRUE,
            timevisOutput('timeline')
          )
        )
    
  )
)