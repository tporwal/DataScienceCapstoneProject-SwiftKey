#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny)
))

# give the application a title and browser tab text
appTitle = (div(HTML("<center>SwiftKey Data Science Johns Hopkins University Coursera Capstone Project</center>")))

# create tabs and panels
shinyUI(fluidPage(
    titlePanel(appTitle,browserText),
    theme = shinytheme("united"),
               sidebarLayout(
                   sidebarPanel(
                   h3("Overview"),
                   p("This application will predict next words for you based on the word or phrase you enter.  
                   Please, note that only English is supported."),
                   h3("Instructions"),
                   tags$ul(
                       tags$li("Enter a phrase in English, into the textbox 'Input'"), 
                       tags$li("Click anywhere outside the textbox"), 
                       tags$li("Your 'suggested next word' will appear below the textbox"),
                       tags$li("Also Your given input will appear below the suggested next word")
                   ),
                   ),
                   mainPanel(id="mainpanel",
                             textInput("text", "Input"),
                             h4("Suggested next word:"),
                             tags$span(style="color:red",
                             tags$strong(tags$h3(textOutput("nextWords")))),
                   h4("Your input:"),
                   tags$span(style="color:red",
                             tags$em(tags$h3(textOutput("inputWords")))), align="center"))
               )
    )