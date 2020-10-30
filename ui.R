# Diamonds Price Estimation
# ui.R

library(shiny)
library(ggplot2)
library(plotly)
data(diamonds)

shinyUI(fluidPage(

    # Application title
    titlePanel("Diamonds Price Estimation 10/30/2020"),

    # Sidebar for information of the diamond piece to use
    sidebarLayout(
        sidebarPanel(
            sliderInput("i_carat", "Carat:",
                        min = 0.0,
                        max = 5.0,
                        value = 1.5,
                        step = 0.1),
            selectInput("i_cut", "Cut:",
                        c("Fair" = "Fair",
                          "Good" = "Good",
                          "Very Good" = "Very Good",
                          "Premium" = "Premium",
                          "Ideal" = "Ideal")),
            selectInput("i_color", "Color:",
                        c("D - Colorless D"      = "D",
                          "E - Colorless E"      = "E",
                          "F - Colorless F"      = "F",
                          "G - Near Colorless G" = "G",
                          "H - Near Colorless H" = "H",
                          "I - Near Colorless I" = "I",
                          "J - Near Colorless J" = "J")),
            selectInput("i_clarity", "Clarity:",
                        c("I1  - Included 1"   = "I1",
                          "SI2 - Slightly Included 2"      = "SI2",
                          "SI1 - Slightly Included 1"      = "SI1",
                          "VS2 - Very Slightly Included 2" = "VS2",
                          "VS1 - Very Slightly Included 1" = "VS1",
                          "VVS2- Very Very Slightly Included 2" = "VVS2",
                          "VVS1- Very Very Slightly Included 1" = "VVS1",
                          "IF  - Internally Flawless"      = "IF"))
            
        ),

        # Results panel
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Result",
                                 br(), 
                                 h2(textOutput("price")),
                                 h3(textOutput("GraphTitle")),
                                 plotlyOutput("diamplot")
                        ),
                        tabPanel("Documentation", br(), htmlOutput("docum")
                                 
                        )
            )
        )
)))
