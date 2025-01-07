# Create the Data View Tab
library(shiny)
library(DT)
library(DBI)
library(RSQLite)

# Define UI for application
ui <- fluidPage(
  navbarPage("Interactive Dashboard",
             tabPanel("Data View",
                      fluidRow(
                        column(12,
                               DTOutput("table1"),
                               DTOutput("table2"),
                               DTOutput("table3"),
                               DTOutput("table4")
                        )
                      )
             ),
             tabPanel("Plot View",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("developer", "Select Developer:", choices = NULL, selected = NULL),
                          dateRangeInput("dateRange", "Select Completion Date Range:")
                        ),
                        mainPanel(
                          plotOutput("plot1"),
                          plotOutput("plot2"),
                          plotOutput("plot3")
                        )
                      )
             )
  )
)

# Define server logic required to draw the tables and plots
server <- function(input, output, session) {
  con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/2023_DAIE_ICA_2_TishLL/ShinyApp_TishLL/shiny_app/ICA_2023.sqlite")
  
  # Data View: Display the contents of four tables
  output$table1 <- renderDT({
    dbGetQuery(con, "SELECT * FROM Table1")
  })
  
  output$table2 <- renderDT({
    dbGetQuery(con, "SELECT * FROM Table2")
  })
  
  output$table3 <- renderDT({
    dbGetQuery(con, "SELECT * FROM Table3")
  })
  
  output$table4 <- renderDT({
    dbGetQuery(con, "SELECT * FROM Table4")
  })
  
  # Update developer choices for the dropdown
  updateSelectInput(session, "developer", choices = dbGetQuery(con, "SELECT DISTINCT DeveloperName FROM Developers"))
  
  # Plot View: Plot data with interactions
  output$plot1 <- renderPlot({
    req(input$developer, input$dateRange)
    data <- dbGetQuery(con, paste0("SELECT * FROM Projects WHERE DeveloperName = '", input$developer, "' AND CompletionDate BETWEEN '", input$dateRange[1], "' AND '", input$dateRange[2], "'"))
    ggplot(data, aes(x = Budget, y = SuccessRate)) +
      geom_point() +
      labs(title = "Success Rate vs Budget")
  })
  
  output$plot2 <- renderPlot({
    req(input$developer, input$dateRange)
    data <- dbGetQuery(con, paste0("SELECT * FROM Projects WHERE DeveloperName = '", input$developer, "' AND CompletionDate BETWEEN '", input$dateRange[1], "' AND '", input$dateRange[2], "'"))
    ggplot(data, aes(x = Timeline, y = Budget)) +
      geom_line() +
      labs(title = "Budget Over Project Timeline")
  })
  
  output$plot3 <- renderPlot({
    req(input$developer, input$dateRange)
    data <- dbGetQuery(con, paste0("SELECT * FROM Assets WHERE DeveloperName = '", input$developer, "' AND CreationDate BETWEEN '", input$dateRange[1], "' AND '", input$dateRange[2], "'"))
    ggplot(data, aes(x = Type, y = Count)) +
      geom_bar(stat = "identity") +
      labs(title = "Asset Types Used by Developer")
  })
  
  session$onSessionEnded(function() {
    dbDisconnect(con)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
