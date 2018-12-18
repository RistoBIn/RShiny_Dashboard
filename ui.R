#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  
  dashboardHeader(title = "Basic dashboard",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Sales Dept",
                                 message = "Sales are steady this month."
                               ),
                               messageItem(
                                 from = "New User",
                                 message = "How do I register?",
                                 icon = icon("question"),
                                 time = "13:45"
                               ),
                               messageItem(
                                 from = "Support",
                                 message = "The new server is ready.",
                                 icon = icon("life-ring"),
                                 time = "2014-12-01"
                               )
                  ),
                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "5 new users today",
                                 icon("users")
                               ),
                               notificationItem(
                                 text = "12 items delivered",
                                 icon("truck"),
                                 status = "success"
                               ),
                               notificationItem(
                                 text = "Server load at 86%",
                                 icon = icon("exclamation-triangle"),
                                 status = "warning"
                               )
                  ),
                  dropdownMenu(type = "tasks", badgeStatus = "success",
                               taskItem(value = 90, color = "green",
                                        "Documentation"
                               ),
                               taskItem(value = 17, color = "aqua",
                                        "Project X"
                               ),
                               taskItem(value = 75, color = "yellow",
                                        "Server deployment"
                               ),
                               taskItem(value = 80, color = "red",
                                        "Overall project"
                               )
                  )
                  ),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      label = "Search..."),
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Info", tabName = "info", icon = icon("info")),
      menuItem("Low Based Layout", tabName = "row", icon = icon("th")),
      menuItem("Column Based Layout", tabName = "column", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(
                    title = "Histogram", status = "primary", solidHeader = TRUE,
                    collapsible = TRUE,
                    plotOutput("plot1", height = 250)
                  ),
                
                box(
                  title = "Inputs", status = "warning", solidHeader = TRUE,
                  "Box content here", br(), "More box content",
                  sliderInput("slider", "Slider input:", 1, 100, 50),
                  textInput("text", "Text input:")              )
              ),
              fluidRow(
                tabBox(
                  title = "First tabBox",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset1", height = "250px",
                  tabPanel("Tab1", "First tab content"),
                  tabPanel("Tab2", "Tab content 2")
                ),
                tabBox(
                  side = "right", height = "250px",
                  selected = "Tab3",
                  tabPanel("Tab1", "Tab content 1"),
                  tabPanel("Tab2", "Tab content 2"),
                  tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                )
              )
      ),
      
      # second tab content
      tabItem(tabName = "info",
              # infoBoxes with fill=FALSE
              fluidRow(
                # A static infoBox
                infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
                # Dynamic infoBoxes
                infoBoxOutput("progressBox"),
                infoBoxOutput("approvalBox")
              ),
              
              # infoBoxes with fill=TRUE
              fluidRow(
                infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                infoBoxOutput("progressBox2"),
                infoBoxOutput("approvalBox2")
              ),
              
              fluidRow(
                # Clicking this will increment the progress amount
                box(width = 4, actionButton("count", "Increment progress"))
              ),
              
              fluidRow(
                # A static valueBox
                valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
                
                # Dynamic valueBoxes
                valueBoxOutput("progressBox1"),
                
                valueBoxOutput("approvalBox1")
              ),
              fluidRow(
                # Clicking this will increment the progress amount
                box(width = 4, actionButton("count1", "Increment progress"))
              )
      ),

      # third tab content
      tabItem(tabName = "row",
              fluidRow(
                box(title = "Box title", "Box content"),
                box(status = "warning", "Box content")
              ),
              
              fluidRow(
                box(
                  title = "Title 1", width = 4, solidHeader = TRUE, status = "primary",
                  "Box content"
                ),
                box(
                  title = "Title 2", width = 4, solidHeader = TRUE,
                  "Box content"
                ),
                box(
                  title = "Title 1", width = 4, solidHeader = TRUE, status = "warning",
                  "Box content"
                )
              ),
              
              fluidRow(
                box(
                  width = 4, background = "black",
                  "A box with a solid black background"
                ),
                box(
                  title = "Title 5", width = 4, background = "light-blue",
                  "A box with a solid light-blue background"
                ),
                box(
                  title = "Title 6",width = 4, background = "maroon",
                  "A box with a solid maroon background"
                )
              )
      ),
      tabItem(tabName = "column",
              fluidRow(
                column(width = 4,
                       box(
                         title = "Box title", width = NULL, status = "primary",
                         "Box content"
                       ),
                       box(
                         title = "Title 1", width = NULL, solidHeader = TRUE, status = "primary",
                         "Box content"
                       ),
                       box(
                         width = NULL, background = "black",
                         "A box with a solid black background"
                       )
                ),
                
                column(width = 4,
                       box(
                         status = "warning", width = NULL,
                         "Box content"
                       ),
                       box(
                         title = "Title 3", width = NULL, solidHeader = TRUE, status = "warning",
                         "Box content"
                       ),
                       box(
                         title = "Title 5", width = NULL, background = "light-blue",
                         "A box with a solid light-blue background"
                       )
                ),
                
                column(width = 4,
                       box(
                         title = "Title 2", width = NULL, solidHeader = TRUE,
                         "Box content"
                       ),
                       box(
                         title = "Title 6", width = NULL, background = "maroon",
                         "A box with a solid maroon background"
                       )
                )
              )
      )
    )
  )
)