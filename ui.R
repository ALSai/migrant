
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("spacelab"),
  
  tags$style(type = 'text/css', '
    footer{text-align:center;}
    h2{text-align:center; padding-bottom:20px;}
  '),
                  
  # Application title
  titlePanel("Chances of having a refugee status per profile and per country"),
  
  # Description
  wellPanel("This application let you see chances of having a refugee status in each european country. Choose the migrant's profile and look the stacked bar. Absolute values (in people) are shown by default to see volume of askings and decision. Percentage of decision can also be shown per country using the tab."),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    
    h3("Migrant's profile"),
    
    radioButtons("sex", "Sex:",
      c("Unknown" = "T",
        "Male" = "M",
       "Female" = "F"
       ), inline = TRUE
    ),
    
    radioButtons("age", "Age:",
      c("Unknown" = "TOTAL",
        "- 14" = "Y_LT14",
        "14 - 17" = "Y14-17",
        "18 - 34" = "Y18-34",
        "35 - 64" = "Y35-64",
        "65 +" = "Y_GE65"
      ), inline = TRUE
    ),
    
    selectInput("origin", "Origin:",
      c(
      )
    ),
    
    helpText("If you don't have any information about the migrant, choose \"Unknown\".")
    
  ),

  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("People", plotOutput("absoluteGraph")), 
      tabPanel("Percentage", plotOutput("percentageGraph"))
    )
  ),
  
  HTML('
    <footer><span class="help-block">All data are from <a href="http://ec.europa.eu/eurostat">eurostat</a>. Application made by Simon "ALSimon" Gilliot.</span></footer>')
  )
  
)
