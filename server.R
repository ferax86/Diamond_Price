# Diamonds Price Estimation
# server.R

library(shiny)
library(ggplot2)
library(scales)
library(plotly)
data(diamonds)

shinyServer(function(input, output) {

    # Fit the model 
    fitModel <- lm(I(log(price)) ~ I(carat^(1/3)) + carat + cut + color + clarity, 
                   data = diamonds)
 
    # Predict with the user input   
    pricePred <- reactive({
        
       predict(fitModel, 
            newdata = data.frame(carat = input$i_carat,
                                 cut = input$i_cut,
                                 color = input$i_color,
                                 clarity = input$i_clarity))
       
    })
 
    # Format the price estimation   
    output$price <- renderText({
        
        paste("Estimated price = ",
              dollar( round(exp(pricePred()), -1)  ),
              sep = "")
    })
    
   
    # Form the title for the plot 
    output$GraphTitle <- renderText({
        
        paste("Data used to build the estimation model (Cut attribute not shown)")
    })
    
    # Form the plot with plotly
    output$diamplot <- renderPlotly({
    
        plot_ly(diamonds, x = ~carat, z = ~price, y = ~clarity, color = ~color, 
                type = "scatter3d", mode = "markers", size = c(1))
    })
    
    # Build the information for the documentation tab
    output$docum <- renderText({
        
        paste0("<h3><b>Objective</b></h3>",
               "This program estimates the market price of diamond pieces base on
               four attributes: <i>carat, cut, color</i> and <i>clarity</i>. 
               These attributes are evaluated according with generally 
               accepted criteria well known in the market.",
               "<h3><b>How to use</h3></b></h3>",
               "To enter the <i>carat</i> value, move the slider with the mouse to 
               a particular value. To enter the value for the other three 
               attributes, select the value from the different options
               provided.",
               "<br/><br/>",
               "As you change de value of any attribute, the program
               automatically calculates the estimate market price of the diamond
               piece. It is shown in the <i>Result</i> tab.",
               "<h3><b>Source of information</h3></b></h3>",
               "The estimation is provided using a prediction  model based on 
               the information contained in the <i>diamond dataset</i> that 
               comes with the <i>ggplot2</i> R package. The dataset contains information on prices of diamonds, as well 
               as various attributes of diamonds, some of which are known to
               determine their price. For the model, the attributes <i>carat, 
               cut, color</i> and <i>clarity</i> were selected.",
               "<br/><br/>",
               "Below the price estimation, a dynamic graph with the 
               information of the <i>diamond dataset</i> is shown (except the
               <i>cut attribute</i>).",
               "<br/><br/>",
               "It is important to note that the prices in the <i>diamond 
               dataset</i> are given in terms of 2008 prices, so it is requered
               that the program estimation be adjusted by factors like inflation,
               market changes, etc."
               )
    })
    
    
})
