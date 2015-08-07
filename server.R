
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(scales)
library(eurostat)


shinyServer(function(input, output, session) {
 
  if (file.exists("dataset.rds")) {
    
    print("Loading data from cache")
    dataset <- readRDS(file="dataset.rds")
    
  } else {
    
    print("Retrieving data")
    dataset <- get_eurostat("migr_asydcfina")
  
    print("Cleaning data")
    # Deleting usefull columns
    dataset$unit <- NULL
    
    # Cleaning ages
    dataset <- dataset[!dataset$age %in% c("UNK"),]
    
    # Cleaning sex
    dataset <- dataset[!dataset$sex %in% c("UNK"),]
    
    # Cleaning geo
    dataset <- dataset[!dataset$geo %in% c("TOTAL","EU28"),]
    
    # Cleaning citizen
    dataset <- dataset[!dataset$citizen %in% c("EXT_EU28","EU28"),]
    
    # Cleaning decision
    dataset <- dataset[!dataset$decision %in% c("TOTAL","TOTAL_POS"),]
    
    # Time -> year
    dataset$year <- format(dataset$time, format="%Y")
    dataset$time <- NULL
    
    # Keeping 2014
    dataset <- dataset[dataset$year == 2014,]
    
    # Aggregating (for having last year)
    #dataset <- dataset[order(dataset$year),]
    #dataset <- aggregate(values ~ decision + citizen + sex + age + geo, dataset, FUN=tail, 1)
    
    # Saving into cache
    saveRDS(dataset, file="dataset.rds")
    
  }
  
  print("Retrieving countries")
  # Countries list
  countries <- aggregate(values ~ citizen, dataset, FUN=sum)
  countries <- as.character(countries[order(countries$values, decreasing = TRUE), "citizen"])
  names(countries) <- label_eurostat(countries, dic="citizen")
  names(countries)[1] <- "Unknown"
  updateSelectInput(session, "origin", choices = countries)
  
  print("Ready...")
  
  output$absoluteGraph <- renderPlot({
    extractedData <- dataset[(dataset$sex == input$sex) & (dataset$age == input$age) & (dataset$citizen == input$origin), c("geo", "values", "decision")]
    plot <- ggplot(extractedData, aes(x=geo, y=values, fill=decision), color=decision) +
      stat_identity(position="stack", geom="bar") +
      scale_y_continuous("People") +
      scale_x_discrete("Destination") +
      scale_fill_discrete(name="Decision:", labels=c("Geneva Convention", "Humanitarian reasons", "Rejected", "Subsidiary protection", "Temporary protection")) +
      theme(legend.position="bottom")
    suppressWarnings(print(plot))
  })
  
  output$percentageGraph <- renderPlot({
    extractedData <- dataset[(dataset$sex == input$sex) & (dataset$age == input$age) & (dataset$citizen == input$origin), c("geo", "values", "decision")]
    plot <- ggplot(extractedData, aes(x=geo, y=(values)/tapply(values,geo,sum)[geo], fill=decision), color=decision) +
      stat_identity(position="stack", geom="bar") +
      scale_y_continuous("Percentage", labels = percent_format()) +
      scale_x_discrete("Destination") +
      scale_fill_discrete(name="Decision:", labels=c("Geneva Convention", "Humanitarian reasons", "Rejected", "Subsidiary protection", "Temporary protection")) +
      theme(legend.position="bottom")
    suppressWarnings(print(plot))
  })
  
})
