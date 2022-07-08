#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(data.table)
library(elastic)
library(elasticsearchr)

header <- dashboardHeader(title = "QA4R - QA System for R Packages",
                          titleWidth = 350)

sidebar <- dashboardSidebar(width = 350,
                            sidebarSearchForm(textId = "searchText", buttonId = "searchButton", 
                                              label = "Search", icon = shiny::icon("search"))
)

body <- dashboardBody(tableOutput("filtered_table"))

ui <- dashboardPage(title = 'QA System for R Packages', header, sidebar, body)


server <- function(input, output, session) {
    
    conn <- connect('http://localhost')
    #Search(conn, index='r_packages_list', q = 'tidy', size=10)$hits$hits
    
    output$filtered_table <- renderTable({
        req(input$searchButton == TRUE)
        Search(conn, index='r_packages_list', pretty = TRUE, q = input$searchText, 
               body = '{
                        "sort": { "_score": { "order": "desc" }}
                        }', 
               size=1)$hits$hits [[1]][5][[1]]
    })
    
}

shinyApp(ui = ui, server = server)