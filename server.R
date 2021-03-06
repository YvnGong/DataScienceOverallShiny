library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyjs)
library(shinyDND)
library(shinyWidgets)
library(dplyr)
library(EDAWR)
library(mosaic)
library(plot3D)
library(plotly)
library(ggplot2)
library(ggmap)
#used for intro part
library(datasets)

shinyServer(function(input, output, session) {
  observeEvent(input$info0,{
    sendSweetAlert(
      session = session,
      title = "Instructions:",
      text = "Move the sliders or select from the dropdown menus and view the R code that produces the results.",
      type = "info"
    )
  })
  observeEvent(input$info,{
    sendSweetAlert(
      session = session,
      title = "Instructions:",
      text = "Move the sliders or select from the dropdown menus and view the R code that produces the results.",
      type = "info"
    )
  })
  observeEvent(input$go2, {
    updateTabItems(session, 'tabs', 'exp4')
  })

###########One Single Variable Plot##############
  output$onescatter<-
    renderPlot({
      if (input$dataset == 'cars'){
        if (input$carsVariable == 'speed'){
          plot(density(cars$speed), main = "Scatter Plot", xlab = input$carsVariable)
        }
        else if(input$carsVariable == 'dist'){
          plot(density(cars$dist), main = "Scatter Plot", xlab = input$carsVariable)
        }
      }
      else if (input$dataset == 'trees'){
        if (input$treesVariable == 'Girth'){
          plot(density(trees$Girth), main = "Scatter Plot", xlab = input$carsVariable)
        }
        else if(input$treesVariable == 'Height'){
          plot(density(trees$Height), main = "Scatter Plot", xlab = input$carsVariable)
        }
        else if(input$treesVariable == 'Volume'){
          plot(density(trees$Volume), main = "Scatter Plot", xlab = input$carsVariable)
        }
      }
    })
  
  output$onehist<-renderPlot({
    if (input$dataset == 'cars'){
      if (input$carsVariable == 'speed'){
        hist(cars$speed, main = "Histogram", xlab = input$carsVariable)
      }
      else if(input$carsVariable == 'dist'){
        hist(cars$dist, main = "Histogram", xlab = input$carsVariable)
      }
    }
    else if (input$dataset == 'trees'){
      if (input$treesVariable == 'Girth'){
        hist(trees$Girth, main = "Histogram", xlab = input$carsVariable)
      }
      else if(input$treesVariable == 'Height'){
        hist(trees$Height, main = "Histogram", xlab = input$carsVariable)
      }
      else if(input$treesVariable == 'Volume'){
        hist(trees$Volume, main = "Histogram", xlab = input$carsVariable)
      }
    }
  })
    
  output$onebar<-
    renderPlot({
      if (input$dataset == 'cars'){
        if (input$carsVariable == 'speed'){
          barplot(cars$speed, main = "Bar Plot", xlab = input$carsVariable)
        }
        else if(input$carsVariable == 'dist'){
          barplot(cars$dist, main = "Bar Plot", xlab = input$carsVariable)
        }
      }
      else if (input$dataset == 'trees'){
        if (input$treesVariable == 'Girth'){
          barplot(trees$Girth, main = "Bar Plot", xlab = input$carsVariable)
        }
        else if(input$treesVariable == 'Height'){
          barplot(trees$Height, main = "Bar Plot", xlab = input$carsVariable)
        }
        else if(input$treesVariable == 'Volume'){
          barplot(trees$Volume, main = "Bar Plot", xlab = input$carsVariable)
        }
      }
    })
  
  output$oneqq<-
    renderPlot({
      if (input$dataset == 'cars'){
        if (input$carsVariable == 'speed'){
          qqnorm(cars$speed)
          qqline(cars$speed, col='red')
        }
        else if(input$carsVariable == 'dist'){
          qqnorm(cars$dist)
          qqline(cars$dist, col='red')
        }
      }
      else if (input$dataset == 'trees'){
        if (input$treesVariable == 'Girth'){
          qqnorm(trees$Girth)
          qqline(trees$Girth, col='red')
        }
        else if(input$treesVariable == 'Height'){
          qqnorm(trees$Height)
          qqline(trees$Height, col='red')
        }
        else if(input$treesVariable == 'Volume'){
          qqnorm(trees$Volume)
          qqline(trees$Volume, col='red')
        }
      }
    })
  
  output$DensityoneCode <- renderUI({
    if (input$dataset == 'cars'){
    tags$code('plot(density(', input$dataset, '$', input$carsVariable, '))')
  }
    else{
    tags$code('plot(density(', input$dataset, '$', input$treesVariable, ')')
    }
    })
  
  output$HistogramoneCode <- renderUI({
    if (input$dataset == 'cars'){
      tags$code('hist(', input$dataset, '$', input$carsVariable, ')')
    }
    else{
      tags$code('hist(', input$dataset, '$', input$treesVariable, ')')
    }
  })
  
  output$BarCode <- renderUI({
    if (input$dataset == 'cars'){
      tags$code('barplot(', input$dataset, '$', input$carsVariable, ')')
    }
    else{
      tags$code('barplot(', input$dataset, '$', input$treesVariable, ')')
    }
  })
  
  output$qqCode <- renderText({
    if (input$dataset == 'cars'){
      paste0('qqnorm(', input$dataset, '$', input$carsVariable, ')',
            '\n qqline(', input$dataset, '$', input$carsVariable, ')', seq='')
    }
    else{
      paste0('qqnorm(', input$dataset, '$', input$treesVariable, ')',
                'qqline(', input$dataset, '$', input$treesVariable, ')', seq='')
    }
  })
  
  
  output$twoscatter<-renderPlot({
    if(input$continuous1=='Sepal.Length'){
      if(input$continuous2=='Petal.Length'){
        ggplot(aes(Sepal.Length, Petal.Length), data=iris)+
          geom_point(aes(colour = factor(Species)))
      }
      else if(input$continuous2=='Petal.Width'){
        ggplot(aes(Sepal.Length, Petal.Width), data=iris)+
          geom_point(aes(colour = factor(Species)))
      }
    }
    else if(input$continuous1=='Sepal.Width'){
      if(input$continuous2=='Petal.Length'){
        ggplot(aes(Sepal.Width, Petal.Length), data=iris)+
          geom_point(aes(colour = factor(Species)))
      }
      else if(input$continuous2=='Petal.Width'){
        ggplot(aes(Sepal.Width, Petal.Width), data=iris)+
          geom_point(aes(colour = factor(Species)))
      }
    }
  })
  
  
  output$sunflower<-renderPlot({
    if(input$continuous1=='Sepal.Length'){
      if(input$continuous2=='Petal.Length'){
        sunflowerplot(Sepal.Length~Petal.Length, data=iris)
      }
      else if(input$continuous2=='Petal.Width'){
        sunflowerplot(Sepal.Length~Petal.Width, data=iris)
      }
    }
    else if(input$continuous1=='Sepal.Width'){
      if(input$continuous2=='Petal.Length'){
        sunflowerplot(Sepal.Width~Petal.Length, data=iris)
      }
      else if(input$continuous2=='Petal.Width'){
        sunflowerplot(Sepal.Width~Petal.Width, data=iris)
      }
    }
  })
  
  
  
  
############ Reshaping Data ############
  # observeEvent(input$knob1, {
  #   updateKnobInput(session, inputId = 'knob2', label = 'Select the Maximum Value for the First Column', value = input$knob1)
  # })
  # 
  # observe(updateKnobInput(session, inputId = 'knob4', value = input$knob3 + input$knob2 - input$knob1))
  
  #unite
  output$uniteUI <- renderUI ({
    if (input$unite3 == T) {
      tags$code('R code: tidyr::unite(mtcars, "New_Column_Name", c(input$unite1))') 
    }
  })
  
  output$uniteOutput1 <- renderTable ({
    head(mtcars)
  })
  
  output$uniteOutput2 <- renderTable ({
    if (input$unite3 == T) {
      head(tidyr::unite(mtcars, 'New_Column', c(input$unite1)))
    }
  })
  
  #arrange: default setting is low to high
  output$dwTable8 <- renderTable ({
    if (input$dwSTI2 == 'Low to High') {
      head(dplyr::arrange(mtcars, mtcars[ , input$dwSTI1]))
    }
    else if (input$dwSTI2 == 'High to Low') {
      head(dplyr::arrange(mtcars, desc(mtcars[ , input$dwSTI1])))
    }
    else {
      head(head(mtcars))
    }
  })
  
  output$code1 <- renderUI ({
    if (input$dwSTI2 == 'Low to High') {
      tags$code(paste('Code: dplyr::arrange(mtcars, mtcars[ , ', input$dwSTI1, ']'))
    }
  })
  
  output$code2 <- renderUI ({
    if (input$dwSTI2 == 'High to Low') {
      tags$code(paste('Code: dplyr::arrange(mtcars, descmtcars[ , ', input$dwSTI1, '])'))
    }
  })
  
  # #data frame
  # output$dfCode <- renderUI ({
  #   tags$code('dplyr::data_frame(a =', input$knob1, ':', input$knob2, ', b =', input$knob3, ':', input$knob4, ')')
  # })
  # 
  # output$dwTable7 <- renderDataTable({
  #   dplyr::data_frame(a = input$knob1:input$knob2, b = input$knob3:input$knob4)
  # })
  
  #gather
  output$dwTable1 <- renderTable({
    cases
  })
  
  output$dwTable2 <- renderTable({
    if (input$dw1 == TRUE) {
      tidyr::gather(cases, "year", "n", 2:4)
    }
  })
  
  #spread
  output$dwTable5 <- renderTable({
    pollution
  })
  
  output$dwTable6 <- renderTable({
    if (input$dw3 == TRUE) {
      tidyr::spread(pollution, size, amount)
    }
  })
  
############
  observeEvent(input$check1, {
    if (input$cd1 == 'left join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  observeEvent(input$check2, {
    if (input$cd2 == 'inner join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  observeEvent(input$check3, {
    if (input$cd3 == 'full join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  observeEvent(input$check4, {
    if (input$cd4 == 'right join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  observeEvent(input$check5, {
    if (input$cd5 == 'anti join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  observeEvent(input$check6, {
    if (input$cd6 == 'semi join') {
      sendSweetAlert(session, title = NULL, text = 'Congratulations', type = 'success', closeOnClickOutside = TRUE)
    }
    else {
      sendSweetAlert(session, title = NULL, text = 'Check Your Answer Again', type = 'error', closeOnClickOutside = TRUE)
    }
  })
  
  #correct answer: A, C, D, B --- left/inner/full/right
  output$cdTable1 <- renderTable({
    dplyr::left_join(a, b, by = "x1")
  })
  
  output$cdTable2 <- renderTable({
    dplyr::inner_join(a, b, by = "x1")
  })
  
  output$cdTable3 <- renderTable({
    dplyr::full_join(a, b, by = "x1")
  })
  
  output$cdTable4 <- renderTable({
    dplyr::right_join(a, b, by = "x1")
  })
  
  output$cdTable5 <- renderTable({
    dplyr::anti_join(a, b, by = "x1")
  })
  
  output$cdTable6 <- renderTable({
    dplyr::semi_join(a, b, by = "x1")
  })
  
  #cd Exp 1-6
  output$cdExp1 <- renderText ({
    if (input$cd1 == 'left join') {
      paste('Join matching rows from b to a.')
    }
    else if (input$cd1 == 'right join') {
      paste('Join matching rows from a to b.')
    }
    else if (input$cd1 == 'inner join') {
      paste('Join data. Retain only rows in both sets.')
    }
    else {
      paste('Join data. Retain all values, all rows.')
    }
  })
  
  output$cdExp2 <- renderText ({
    if (input$cd2 == 'left join') {
      paste('Join matching rows from b to a.')
    }
    else if (input$cd2 == 'right join') {
      paste('Join matching rows from a to b.')
    }
    else if (input$cd2 == 'inner join') {
      paste('Join data. Retain only rows in both sets.')
    }
    else {
      paste('Join data. Retain all values, all rows.')
    }
  })
  
  output$cdExp3 <- renderText ({
    if (input$cd3 == 'left join') {
      paste('Join matching rows from b to a.')
    }
    else if (input$cd3 == 'right join') {
      paste('Join matching rows from a to b.')
    }
    else if (input$cd3 == 'inner join') {
      paste('Join data. Retain only rows in both sets.')
    }
    else {
      paste('Join data. Retain all values, all rows.')
    }
  })
  
  output$cdExp4 <- renderText ({
    if (input$cd4 == 'left join') {
      paste('Join matching rows from b to a.')
    }
    else if (input$cd4 == 'right join') {
      paste('Join matching rows from a to b.')
    }
    else if (input$cd4 == 'inner join') {
      paste('Join data. Retain only rows in both sets.')
    }
    else {
      paste('Join data. Retain all values, all rows.')
    }
  })
  
############ Data Visualization ############
  
  ###### Maps ######
  #a. usMap
  output$usMapOut1 <- renderPlot({
    USArrests2 <- USArrests %>% mutate(state = row.names(.))
    if (input$usMap1 == 'borders' & input$usMap2 == 'compact') {
      mUSMap(USArrests2, key = "state", fill = "UrbanPop", plot = 'borders', style = 'compact')
    }
    else if (input$usMap1 == 'borders' & input$usMap2 == 'real') {
      mUSMap(USArrests2, key = "state", fill = "UrbanPop", plot = 'borders', style = 'real')
    }
    else if (input$usMap1 == 'frame' & input$usMap2 == 'compact') {
      mUSMap(USArrests2, key = "state", fill = "UrbanPop", plot = 'frame', style = 'compact')
    }
    else {
      mUSMap(USArrests2, key = "state", fill = "UrbanPop", plot = 'frame', style = 'real')
    }
  })
  
  output$usMapOut2 <- renderUI ({
    tags$code('mUSMap(USArrests2, key = "state", fill = "UrbanPop", plot = "', input$usMap1, '", style = "', input$usMap2, '")')
  })
  
  #plotly US Map - code
  output$plotlyUScode <- renderUI ({
    tags$code('p <- plot_geo(df, locationmode = "USA-states", sizes = c(1, 250))')
  })
  
  #plotly US Map
  output$plotlyUSMap <- renderPlotly({
    df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv')
    df$q <- with(df, cut(pop, quantile(pop)))
    levels(df$q) <- paste(c("1st", "2nd", "3rd", "4th", "5th"), "Quantile")
    df$q <- as.ordered(df$q)
    
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showland = TRUE,
      landcolor = toRGB("gray85"),
      subunitwidth = 1,
      countrywidth = 1,
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white")
    )
    
    p <- plot_geo(df, locationmode = 'USA-states', sizes = c(1, 250)) %>%
      add_markers(
        x = ~lon, y = ~lat, size = ~pop, color = ~q, hoverinfo = "text",
        text = ~paste(df$name, "<br />", df$pop/1e6, " million")
      ) %>%
      layout(title = '2014 US city populations<br>(Click legend to toggle)', geo = g)
    g
    p
  })
  
  # #b. worldMap
  # output$worldMapOut1 <- renderPlot ({
  #   gdpData <- gdpData %>% mutate(GDPOption = ntiles(-GDP, input$worldMap1, format = "rank"))
  #   mWorldMap(gdpData, key = "country", fill = "GDPOption")
  # })
  # 
  # output$worldMapCode1 <- renderUI ({
  #   tags$code('gdpData <- gdpData %>% mutate(GDPOption = ntiles(-GDP,', input$worldMap1, ', format = "rank"))')
  # })
  # 
  # output$worldMapCode2 <- renderUI ({
  #   tags$code('mWorldMap(gdpData, key = "country", fill = "GDPOption")')
  # })
  
  ###### 3D Plots ######
  #a. Normal Simulation via Plotly
  output$plotly1 <- renderPlotly ({
    plot_ly(x = rnorm(input$Exsel1), y = rnorm(input$Exsel1), z = rnorm(input$Exsel1), 
            type = 'scatter3d', mode = 'markers')
  })
  
  output$ExCode <- renderUI ({
    tags$code('plot_ly(x = rnorm(', input$Exsel1, '), y = rnorm(', input$Exsel1, '), z = rnorm(', input$Exsel1, '), type = "scatter3d", mode = "markers")')
  })
  
  # output$plotly1 <- renderPlotly ({
  #   if (input$Exsel == 'Scatter Plot') {
  #     plot_ly(x = rnorm(input$Exsel1), y = rnorm(input$Exsel1), z = rnorm(input$Exsel1), 
  #             type = 'scatter3d', mode = 'markers')
  #   }
  #   else if (input$Exsel == 'Line Plot') {
  #     plot_ly(x = rnorm(input$Exsel1), y = rnorm(input$Exsel1), z = rnorm(input$Exsel1), 
  #             type = 'scatter3d', mode = 'lines') 
  #   }
  #   else {
  #     plot_ly(x = rnorm(input$Exsel1), y = rnorm(input$Exsel1), z = rnorm(input$Exsel1), 
  #             type = 'mesh3d', mode = 'markers') 
  #   }
  # })
  
  output$hover <- renderPrint({
    dataHover <- event_data("plotly_hover")
    if (is.null(dataHover)) {
      "Hover events appear here (unhover to clear)" 
    }
    else {
      dataHover
    }
  })
  
  output$click <- renderPrint({
    dataClick <- event_data("plotly_click")
    if (is.null(dataClick)) {
      "Click events appear here (double-click to clear)"
    }
    else {
      dataClick
    }
  })
  
  # output$ExCode <- renderUI ({
  #   if (input$Exsel == 'Scatter Plot') {
  #     tags$code('plot_ly(x = rnorm(', input$Exsel1, '), y = rnorm(', input$Exsel1, '), z = rnorm(', input$Exsel1, '), type = "scatter3d", mode = "markers")')
  #   }
  #   else if (input$Exsel == 'Line Plot') {
  #     tags$code('plot_ly(x = rnorm(', input$Exsel1, '), y = rnorm(', input$Exsel1, '), z = rnorm(', input$Exsel1, '), type = "scatter3d", mode = "lines")')
  #   }
  #   else {
  #     tags$code('plot_ly(x = rnorm(', input$Exsel1, '), y = rnorm(', input$Exsel1, '), z = rnorm(', input$Exsel1, '), type = "mesh3d", mode = "markers")')
  #   }
  # })
  
  #b. Basic Scatter Plot
  output$basicRcode <- renderUI ({
    tags$code('scatter3D(x, y, z, clab = c("Sepal", "Width (cm)"), xlab = input$basicX, ylab = input$basicY, zlab = input$basicZ)')
  })
  
  output$bspTable <- renderTable ({
    head(iris)
  })
  
  output$bspOut1 <- renderPlot({
    x <- iris[, input$basicX]
    y <- iris[, input$basicY]
    z <- iris[, input$basicZ]
    scatter3D(x, y, z, clab = c("Sepal", "Width (cm)"), xlab = input$basicX, ylab = input$basicY, zlab = input$basicZ)
  })
  
  # #c.
  # output$bspTableCopy <- renderTable ({
  #   head(iris)
  # })
  # 
  # output$bspOut2 <- renderPlot ({
  #   scatter3D(x, y, z, bty = "g", pch = 18, 
  #             col.var = as.integer(iris$Species), 
  #             col = c("#1B9E77", "#D95F02", "#7570B3"),
  #             pch = 18, ticktype = "detailed",
  #             colkey = list(at = c(2, 3, 4), side = 1, 
  #                           addlines = TRUE, length = 0.5, width = 0.5,
  #                           labels = c("setosa", "versicolor", "virginica")) )
  # })
  
  # #d. 3D Plots with Confidence Intervals
  # output$CIOut <- renderPlot ({
  #   x <- iris[, input$CIX]
  #   y <- iris[, input$CIY]
  #   z <- iris[, input$CIZ]
  #   CI <- list(z = matrix(nrow = length(x),
  #                         data = rep(0.1, 2*length(x))))
  #   scatter3D(x, y, z, phi = 0, bty = "g", col = gg.col(100), 
  #             pch = 18, CI = CI)
  # })
  
  #e. 3D Texts Plot
  output$textRcode <- renderUI ({
    tags$code('with(USArrests, text3D(Murder, Assault, Rape, 
                           labels = rownames(USArrests), colvar = UrbanPop, 
              col = gg.col(100), theta = 60, phi = 20,
              xlab = "Murder", ylab = "Assault", zlab = "Rape", 
              main = "USA arrests", cex = 0.6, 
              bty = "g", ticktype = "detailed", d = 2,
              clab = c("Urban","Pop"), adj = 0.5, font = 2))')
  })
  
  output$textTable <- renderTable ({
    head(USArrests)
  })
  
  output$textOut <- renderPlot ({
    data(USArrests)
    with(USArrests, text3D(Murder, Assault, Rape, 
                           labels = rownames(USArrests), colvar = UrbanPop, 
                           col = gg.col(100), theta = 60, phi = 20,
                           xlab = "Murder", ylab = "Assault", zlab = "Rape", 
                           main = "USA arrests", cex = 0.6, 
                           bty = "g", ticktype = "detailed", d = 2,
                           clab = c("Urban","Pop"), adj = 0.5, font = 2))
  })
  
  ###### 2D Line Plots ######
  output$plotly2 <- renderPlotly ({
    trace_0 <- rnorm(as.numeric(input$LPsel1), mean = as.numeric(input$LPnum1))
    trace_1 <- rnorm(as.numeric(input$LPsel1), mean = as.numeric(input$LPnum2))
    x = c(1:as.numeric(input$LPsel1))
    data <- data.frame(x, trace_0, trace_1)
    if (input$LPSEL1 == 'Lines' & input$LPSEL2 == 'Lines') {
      plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'lines') %>%
        add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines')
    }
    else if (input$LPSEL1 == 'Markers' & input$LPSEL2 == 'Markers') {
      plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'markers') %>%
        add_trace(y = ~trace_1, name = 'trace 1', mode = 'markers')
    }
    else if (input$LPSEL1 == 'Lines' & input$LPSEL2 == 'Markers') {
      plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'lines') %>%
        add_trace(y = ~trace_1, name = 'trace 1', mode = 'markers')
    }
    else {
      plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'markers') %>%
        add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines')
    }
  })
  
  output$LPCode <- renderUI ({
    tags$code('plot_ly(data, x = ~x, y = ~trace_0, name = "trace 0", type = "scatter", mode = "lines") %>%
              add_trace(y = ~trace_1, name = "trace 1", mode = "markers + lines")')
  })
  
  ###### Contour Plots and Heatmaps ######
  #contour plot
  output$proteinInt <- renderPlot ({
    potentials <- as.matrix(read.table("MULTIPOT_lu.txt", row.names=1, header=TRUE))
    matrix.axes <- function(data) {
      # Do the rows, las=2 for text perpendicular to the axis
      x <- (1:dim(data)[1] - 1) / (dim(data)[1] - 1);
      axis(side=1, at=x, labels=rownames(data), las=2);
      # Do the columns
      x <- (1:dim(data)[2] - 1) / (dim(data)[2] - 1);
      axis(side=2, at=x, labels=colnames(data), las=2);
    }
    filled.contour(potentials, plot.axes=matrix.axes(potentials), main = "Protein-Protein Interaction Potential")
  })
  
  output$plotly3 <- renderPlotly({
    if (input$contourLabel == FALSE) {
      plot_ly(z = volcano, type = "contour", colors = colorRamp(c("purple", "green")))
    }
    else {
      plot_ly(z = volcano, type = "contour", colors = colorRamp(c("purple", "green")),
              contours = list(showlabels = TRUE))
    }
  })
  
  #contour plot r code
  output$CPCode1 <- renderUI ({
    if (input$contourLabel == FALSE) {
      tags$code('plot_ly(z = volcano, type = "contour", colors = colorRamp(c("purple", "green")))')
    }
    else {
      tags$code('plot_ly(z = volcano, type = "contour", colors = colorRamp(c("purple", "green")), contours = list(showlabels = TRUE))')
    }
  })
  
  #heatmap
  output$plotly4 <- renderPlotly({
    if (input$heatmapCol == 'purple+green') {
      plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("purple", "green")))
    }
    else if (input$heatmapCol == 'yellow+red') {
      plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("yellow", "red")))
    }
    else if (input$heatmapCol == 'pink+purple') {
      plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("pink", "purple")))
    }
    else {
      plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("white", "black")))
    }
  })
  
  #heatmaps r code
  output$CPCode2 <- renderUI ({
    if (input$heatmapCol == 'purple+green') {
      tags$code('plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("purple", "green")))') 
    }
    else if (input$heatmapCol == 'yellow+red') {
      tags$code('plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("yellow", "red")))') 
    }
    else if (input$heatmapCol == 'pink+purple') {
      tags$code('plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("pink", "purple")))') 
    }
    else {
      tags$code('plot_ly(z = volcano, type = "heatmap", colors = colorRamp(c("white", "black")))') 
    }
  })
  
  output$cars1 <- renderPlotly ({
    head(mtcars)
    data = as.matrix(mtcars)
    data=apply(data, 2, function(x){x/mean(x)})
    plot_ly(x=colnames(data), y=rownames(data), z = data, type = "heatmap")
  })
  
})