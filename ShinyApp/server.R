#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

suppressPackageStartupMessages(
    c(library(stringr), library(stylo), library(tm)
))

# include helper functions
source(".//predict.R")
quadgram <- readRDS(file = ".//quadgram.RData")
trigram <- readRDS(file = ".//trigram.RData")
bigram <- readRDS(file = ".//bigram.RData")


# word prediction service
shinyServer(function(input, output) {
    nextWord <- reactive({
        x <- input$text
        y <- callingClean(x)
        wCount <- length(y)
        nextWord <- getNextWord(wCount,y)})
    
    output$nextWords <- renderPrint(nextWord())
    output$inputWords <- renderText({input$text}, quoted = FALSE)
    
})