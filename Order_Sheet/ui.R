#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Order Sheet"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       fileInput('file',
                 'Select Stock file'),
       selectInput('brand','Select Brand',
                   choices = c("FASTRACK", "SONATA", "ZOOP", "TITAN", "CASIO", "TIMEX", "TOMMY",'XYLYS')),
       actionButton('button','Apply Changes')
       
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("table"),
       a('Go to Google Drive',href = 'https://drive.google.com/drive/u/0/my-drive',target='_blank')
    )
  )
))
