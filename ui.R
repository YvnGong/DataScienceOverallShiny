library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyjs)
library(shinyDND)
library(shinyWidgets)
library(dplyr)
library(mosaic)
library(plotly)
library(ggplot2)
library(EDAWR)
library(plot3D)
library(ggmap)

header = dashboardHeader(title = 'Data Science')

sidebar = dashboardSidebar(
  sidebarMenu(id = 'tabs',
              menuItem('Overview', tabName = 'overview', icon = icon("dashboard")),
              menuItem('Data Visualization', tabName = 'exp4', icon = icon('wpexplorer')),
              menuItem('Reshaping Data', tabName = 'exp1', icon = icon('wpexplorer')),
              menuItem('Combining Data Sets', tabName = 'exp2', icon = icon('gamepad'))
              #menuItem('Creating Your Own Graph', tabName = 'exp3', icon = icon('refresh'))
  )
)

body = dashboardBody(
  tags$head( 
    tags$link(rel = "stylesheet", type = "text/css", href = "Feature.css")
  ),
  tags$style(type = "text/css", ".content-wrapper,.right-side {background-color: white;}"),
  #tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  
  useShinyjs(),
  
  tabItems(
    tabItem(tabName = 'overview',
            tags$a(href='http://stat.psu.edu/', tags$img(src = 'psu_icon.jpg', align = "left", width = 180)),
            br(),
            br(),
            br(),
            h3(strong('About:')),
            h4('This app illustrates R code for data visulization, reshaping and combining data. Please refer to the', a(href='https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf', 'Data Wrangling cheatsheet'), 'for all the information needed.'),
            br(),
            
            h3(strong('Instructions:')),
            h4(tags$li('In the Data Visualization section, go through each tab including 3D plots, line plots, contour plots, and heat maps.')),
            h4(tags$li('In the Reshaping Data section, go through each tab including unite, gather, spread, data_frame, and arrange.')),
            h4(tags$li('In the Combining Data Set section, click on the green button to select the transformation corresponding to each data table generated.'))
            ,
            br(),
            div(style = 'text-align: center', bsButton(inputId = 'go2', label = 'Explore', icon = icon('bolt'), size = 'large')),
            br(),
            h3(strong('Acknowledgements:')),
            h4('This application was coded and developed by Anna (Yinqi) Zhang. Special Thanks to Grace (Yubaihe) Zhou for being incredibly helpful with programming issues.'),
            h4('The cheat sheet is provided by RStudio.'),
            h4('Packages used: dplyr, EDAWR, ggmap, mosaic, plotly, ggplot2, plot3D.'),
            h4('The Protein-Protein Interaction Dataset is from the Warwick University - Molecular Organisation and Assembly in Cells.')
            ),

############ Reshaping Data ############
    tabItem(tabName = 'exp1', 
            div(style="display: inline-block;vertical-align:top;",
                tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 19))
            ),
            div(style="display: inline-block;vertical-align:top;",
                circleButton("info0",icon = icon("info"), status = "myClass",size = "xs")
            ),
            tabsetPanel(type = 'tabs',
                        tabPanel('unite',
                                 br(),
                                 box(title = 'View An Example', width = NULL, style = 'background-color: #ff8a80',
                                     tableOutput('uniteOutput1'),
                                     checkboxGroupInput(inputId = 'unite1', label = 'Select Columns to Unite', inline = T,
                                                        choices = c('mpg', 'cyl', 'disp', 'hp', 'drat', 'wt', 'qsec', 'vs', 'am', 'gear', 'carb')
                                                        ),
                                     materialSwitch(inputId = 'unite3', label = 'View the Transformed Data Set', value = FALSE),
                                     uiOutput('uniteUI'),
                                     br(),
                                     tableOutput('uniteOutput2')
                                     )
                                 ),
                        
                        tabPanel('gather',
                                 br(),
                                 box(title = 'View An Example', width = NULL, style = 'background-color: #f8bbd0',
                                     materialSwitch(inputId = 'dw1', label = 'View the Transformed Data Set', value = FALSE),
                                     tableOutput('dwTable1'),
                                     tags$strong(div('Gather columns into rows.', style = 'color: purple')),
                                     tags$code('tidyr::gather(cases, "year", "n", 2:4)'),
                                     br(),
                                     br(),
                                     tableOutput('dwTable2')
                                     )
                                 ),
                        # tabPanel('separate',
                        #          br(),
                        #          box(title = 'View An Example', width = NULL, style = 'background-color: #4dd0e1',
                        #              materialSwitch(inputId = 'dw2', label = 'View the Transformed Data Set', value = FALSE),
                        #              tableOutput('dwTable3'),
                        #              tags$code('Separate one column into several.'),
                        #              br(),
                        #              tableOutput('dwTable4')
                        #              )
                        #          ),
                        tabPanel('spread',
                                 br(),
                                 box(title = 'View An Example', width = NULL, style = 'background-color: #e0f7fa',
                                     materialSwitch(inputId = 'dw3', label = 'View the Transformed Data Set', value = FALSE),
                                     tableOutput('dwTable5'),
                                     tags$strong(div('Spread rows into columns.', style = 'color: green')),
                                     tags$code('tidyr::spread(pollution, size, amount)'),
                                     br(),
                                     br(),
                                     tableOutput('dwTable6')
                                     )
                                 ),
                       
                        tabPanel('arrange',
                                 br(),
                                 box(title = 'View An Example', width = NULL, style = 'background-color: #b2dfdb',
                                     sliderTextInput(inputId = 'dwSTI2', label = 'Select Your Sorting Option',
                                                     choices = c('Random', 'Low to High', 'High to Low'),
                                                     grid = TRUE, force_edges = TRUE
                                                     ),
                                     sliderTextInput(inputId = 'dwSTI1', label = 'Select the Variable to Sort By', 
                                                     choices = c('mpg', 'cyl', 'disp', 'hp', 'drat', 'wt', 'qsec'), 
                                                     grid = TRUE, force_edges = TRUE
                                     ),
                                     tags$strong('R code: '),
                                     tags$li('Order rows by values of a column (low to high)'),
                                     uiOutput('code1'),
                                     br(),
                                     tags$li('Order rows by values of a column (high to low)'),
                                     uiOutput('code2'),
                                     br(),
                                     br(),
                                     tableOutput('dwTable8'))
                                 )
                        )
            ),

############ Combining Data Sets ############    
    tabItem(tabName = 'exp2',
           
            fluidRow(
              column(width = 12,
                     box(title = NULL, style = 'background-color: #b2dfdb', width = NULL, height = NULL,
                         tags$h2('Data Wrangling --- Combining Data Sets'),
                         
                         div(style="display: inline-block;vertical-align:top;",
                             tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 19))
                         ),
                         div(style="display: inline-block;vertical-align:top;",
                             circleButton("info1",icon = icon("info"), status = "myClass",size = "xs")
                         ),
                         bsPopover(id = 'info1', title = " ", content = 'Exercise! Within each box is a transformed dataset. Click on the green label on the upper left corner to select the correct transformation.', placement = 'buttom'),
                         div(style = 'text-align: center', tags$img(src = 'cds.png', width = '300px', height = NULL)),
                         br(),
                         br()
                         )
                     )
            ),
            
            fluidRow(#theme = "bootstrap.css",
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffe0b2', width = NULL, height = '220px',
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('cogs'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd1', label = 'Mutating Joins Option', force_edges = TRUE, grid = TRUE,
                                           choices = c('left join', 'right join', 'inner join', 'full join')
                                           ),
                           textOutput('cdExp1')
                         ),
                         tableOutput('cdTable1'),
                         bsButton(inputId = 'check1', label = 'Check', size = 'median')
                         )
                     ),
              
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffe0b2', width = NULL, height = '220px',
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('cogs'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd2', label = 'Mutating Joins Option', force_edges = TRUE, grid = TRUE,
                                           choices = c('left join', 'right join', 'inner join', 'full join')),
                           textOutput('cdExp2')
                         ),
                         tableOutput('cdTable2'),
                         br(),
                         bsButton(inputId = 'check2', label = 'Check', size = 'median')
                         )
              ),
              
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffccbc', width = NULL, height = '180px',
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('cogs'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd5', label = 'Filtering Joins Option', force_edges = TRUE,
                                           choices = c('semi join', 'anti join')
                                           )
                         ),
                         tableOutput('cdTable5'),
                         br(),
                         bsButton(inputId = 'check5', label = 'Check', size = 'median')
                         )
                     ),
              
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffccbc', width = NULL, height = '180px',
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('cogs'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd6', label = 'Filtering Joins Option', force_edges = TRUE,
                                           choices = c('semi join', 'anti join')
                           )
                         ),
                         tableOutput('cdTable6'),
                         bsButton(inputId = 'check6', label = 'Check', size = 'median')
                         )
                     ),
              
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffe0b2', width = NULL, height = NULL,
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('cogs'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd3', label = 'Mutating Joins Option', force_edges = TRUE, grid = T,
                                           choices = c('left join', 'right join', 'inner join', 'full join')
                                           ),
                           textOutput('cdExp3')
                         ),
                         tableOutput('cdTable3'),
                         bsButton(inputId = 'check3', label = 'Check', size = 'median')
                         )
                     ),
              
              column(width = 6,
                     box(title = NULL, style = 'background-color: #ffe0b2', width = NULL, height = NULL,
                         dropdownButton(
                           circle = TRUE, status = 'success', size = 'xs', icon = icon('adjust'),
                           up = TRUE, right = TRUE, tooltip = tooltipOptions(title = "Select Your Answer"),
                           sliderTextInput(inputId = 'cd4', label = 'Mutating Joins Option', force_edges = TRUE, grid = T,
                                           choices = c('left join', 'right join', 'inner join', 'full join')
                                           ),
                           textOutput('cdExp4')
                         ),
                         tableOutput('cdTable4'),
                         br(),
                         bsButton(inputId = 'check4', label = 'Check', size = 'median')
                         )
                     )
            )
            ),

############ Data Visualization ############
    tabItem(tabName = 'exp4',
            div(style="display: inline-block;vertical-align:top;",
                tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 19))
            ),
            div(style="display: inline-block;vertical-align:top;",
                circleButton("info",icon = icon("info"), status = "myClass",size = "xs")
            ),
            tabsetPanel(type = 'tabs',
                        
                        ###### Maps ######
                        tabPanel('Maps',
                                 br(),
                                 box(title = NULL, style = 'background-color: #dce775', width = NULL, height = NULL,
                                     
                                     selectInput(inputId = 'mapsOp', label = 'Make a US/World Map with ggplot2', choices = c('US Map - ggplot2', 'US Map - plotly'), selected = 'US Map'),
                                     bsPopover(id = 'mapsOp', title = " ", content = 'mUSMap takes in one dataframe that includes information about different US states and returns this data or a ggplot object constructed with the data. mWorldMap does the same but it takes in one dataframe that includes information about different countries.', trigger = 'click'),
                                     
                                     # conditionalPanel('input.mapsOp == "World Map"',
                                     #                  sliderInput(inputId = 'worldMap1', label = 'The Number of Color Scales', min = 1, max = 10,
                                     #                              value = 5, step = 1, ticks = TRUE)
                                     #                  ),
                                     
                                     conditionalPanel('input.mapsOp == "US Map - ggplot2"',
                                                      selectInput(inputId = 'usMap1', label = 'Plot Option', choices = c('borders', 'frame')),
                                                      selectInput(inputId = 'usMap2', label = 'Style Option', choices = c('compact', 'real'))
                                                      )
                  
                                  ),
                                 
                                 box(title = NULL, style = 'background-color: #f0f4c3', width = NULL, height = NULL,
                                     # conditionalPanel('input.mapsOp == "World Map"',
                                     #                  tags$strong('R code: '),
                                     #                  br(),
                                     #                  tags$i('Data Processing:'),
                                     #                  uiOutput('worldMapCode1'),
                                     #                  tags$i('Graph Generating:'),
                                     #                  uiOutput('worldMapCode2'),
                                     #                  br(),
                                     #                  plotOutput('worldMapOut1')
                                     #                  ),
                                     conditionalPanel('input.mapsOp == "US Map - ggplot2"',
                                                      tags$strong('R code: '),
                                                      uiOutput('usMapOut2'),
                                                      br(),
                                                      plotOutput('usMapOut1')
                                                      ),
                                     
                                     conditionalPanel('input.mapsOp == "US Map - plotly"',
                                                      tags$strong('R code: '),
                                                      uiOutput('plotlyUScode'),
                                                      br(),
                                                      plotlyOutput('plotlyUSMap')
                                                      )
                                     )
                                 ),
                        
                        ###### 3D Plots ######
                        tabPanel('3D Plots',
                                 br(),
                                 fluidRow(
                                   column(width = 12,
                                     box(title = NULL, style = 'background-color: #e8eaf6', width = NULL, height = NULL,
                                         selectInput(inputId = 'Exsel', label = '3D Plot Type', 
                                                     choices = c('Normal Simulation via Plotly', '3D Basic Scatter Plot', '3D Texts Plot'),
                                                     # choices = c('Normal Simulation via Plotly', 'Basic Scatter Plot', 'Basic Scatter Plot Colored by Groups', 
                                                     #             '3D Plots with Confidence Intervals', '3D Texts Plot'),
                                                     selected = 'Normal Simulation via Plotly', multiple = FALSE),
                                         
                                         # bsPopover(id = 'Exsel', title = 'Understand the Graph Type', 
                                         #           content = 'Mesh plot generates a wireframe plot while the scatter plot generates a dotted plot.', 
                                         #           placement = 'bottom', trigger = 'hover'),
                                         
                                         #a. Normal Simulation via Plotly
                                         conditionalPanel('input.Exsel == "Normal Simulation via Plotly"',
                                                          sliderInput(inputId = 'Exsel1', label = 'Please Select Your Sample Size', min = 0, max = 100,
                                                                      value = 30, step = 1, ticks = TRUE)
                                                          ),
                                         
                                         #b. Basic Scatter Plot
                                         conditionalPanel('input.Exsel == "3D Basic Scatter Plot"',
                                                          selectInput(inputId = 'basicX', label = 'Variable for X-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Sepal.Length', multiple = FALSE),
                                                          selectInput(inputId = 'basicY', label = 'Variable for Y-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Sepal.Width', multiple = FALSE),
                                                          selectInput(inputId = 'basicZ', label = 'Variable for Z-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Petal.Length', multiple = FALSE)
                                                          ),
                                         #c.
                                         #d. 3D Plots with Confidence Intervals
                                         conditionalPanel('input.Exsel == "3D Plots with Confidence Intervals"',
                                                          selectInput(inputId = 'CIX', label = 'Variable for X-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Sepal.Length', multiple = FALSE),
                                                          selectInput(inputId = 'CIY', label = 'Variable for Y-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Sepal.Width', multiple = FALSE),
                                                          selectInput(inputId = 'CIZ', label = 'Variable for Z-Axis', choices = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                                                                      selected = 'Petal.Length', multiple = FALSE)
                                                          )
                                     )
                                   )
                                 ),
                                 fluidRow(
                                   column(width = 12,
                                          box(title = NULL, style = 'background-color: #9fa8da', width = NULL, height = NULL,
                                              
                                              #a. Normal Simulation via Plotly
                                              conditionalPanel('input.Exsel == "Normal Simulation via Plotly"',
                                                               tags$strong('R code: '),
                                                               uiOutput('ExCode'),
                                                               br(),
                                                               plotlyOutput('plotly1'),
                                                               br(),
                                                               verbatimTextOutput("hover"),
                                                               verbatimTextOutput("click")
                                                               ),
                                              
                                              #b. Basic Scatter Plot
                                              conditionalPanel('input.Exsel == "3D Basic Scatter Plot"',
                                                               tags$strong('R code: '),
                                                               uiOutput('basicRcode'),
                                                               br(),
                                                               tableOutput('bspTable'),
                                                               plotOutput('bspOut1')
                                                               ),
                                              
                                              # #c. Basic Scatter Plot Colored by Groups
                                              # conditionalPanel('input.Exsel == "Basic Scatter Plot Colored by Groups"',
                                              #                  tableOutput('bspTableCopy'),
                                              #                  plotOutput('bspOut2')
                                              # ),
                                              
                                              # #d. 3D Plots with Confidence Intervals
                                              # conditionalPanel('input.Exsel == "3D Plots with Confidence Intervals"',
                                              #                  plotOutput('CIOut')
                                              #                  ),
                                              
                                              #e. 3D Texts Plot
                                              conditionalPanel('input.Exsel == "3D Texts Plot"',
                                                               tags$strong('R code: '),
                                                               uiOutput('textRcode'),
                                                               br(),
                                                               tableOutput('textTable'),
                                                               plotOutput('textOut')
                                                               )
                                              
                                              )
                                          )
                                 )
                                 ),
                        
                        ###### 2D Line Plots ######
                        tabPanel('2D Line Plots',
                                 br(),
                                 fluidRow(
                                   column(width = 12,
                                          box(title = NULL, style = 'background-color: #e8eaf6', width = NULL, height = NULL,
                                              
                                              sliderInput(inputId = 'LPsel1', label = 'Please Set the Maximum of X-Axis', min = 0, max = 200,
                                                          value = 80, step = 1, ticks = TRUE),
                                              
                                              numericInput(inputId = 'LPnum1', label = 'Theoretical Mean of trace 0',
                                                           value = 10, step = 1),
                                              selectInput(inputId = 'LPSEL1', label = 'Please Select Your First Graph Mode',
                                                          choices = c('Lines', 'Markers')),
                                              numericInput(inputId = 'LPnum2', label = 'Theoretical Mean of trace 1',
                                                           value = -10, step = 1),
                                              selectInput(inputId = 'LPSEL2', label = 'Please Select Your Second Graph Mode',
                                                          choices = c('Lines', 'Markers'))
                                          )
                                   )
                                 ),
                                 fluidRow(
                                   column(width = 12,
                                          box(title = NULL, style = 'background-color: #9fa8da', width = NULL, height = NULL,
                                              tags$strong('R code: '),
                                              uiOutput('LPCode'),
                                              br(),
                                              plotlyOutput('plotly2')
                                              )
                                          )
                                 )
                                 ),
                        
                        ###### Contour Plots & Heat Maps ######
                        tabPanel('Contour Plots & Heatmaps',
                                 br(),
                                 sidebarLayout(
                                   sidebarPanel(
                                     box(title = NULL, style = 'background-color: #f0f4c3', width = NULL, height = NULL,
                                         div('Heat maps and contour plots are visualization techniques to show data density on a map. They are particularly helpful when you have a lot of data points on the map and are mainly interested in their overall distribution.', style = 'color: blue'),
                                         br(),
                                         selectInput(inputId = 'chSel', label = 'Please Select Your Display Option', choices = c('', 'Contour Plots', 'Heatmaps'), selected = 'Contour Plots'),
                                         
                                         #contour plots
                                         conditionalPanel('input.chSel == "Contour Plots"',
                                                          selectInput(inputId = 'chSel2', label = 'View An Example', choices = c('Volcano', 'Protein-Protein Interaction')),
                                                          conditionalPanel('input.chSel2 == "Volcano"',
                                                                           checkboxInput(inputId = 'contourLabel', label = 'Add Contour Labels', value = FALSE)
                                                                           )
                                                          ),
                                         
                                         #heat maps
                                         conditionalPanel('input.chSel == "Heatmaps"',
                                                          selectInput(inputId = 'heat1', label = 'View An Example', choices = c('Volcano', 'Cars')),
                                                          conditionalPanel('input.heat1 == "Volcano"',
                                                                           sliderTextInput(inputId = 'heatmapCol', label = 'Please Select Your Colorscale', 
                                                                                           choices = c('purple+green', 'yellow+red', 'pink+purple', 'white+black'), grid = TRUE)
                                                                           )
                                                          
                                                          )
                                     )
                                   ),
                                   
                                   mainPanel(
                                     box(title = NULL, style = 'background-color: #dce775', width = NULL, height = NULL,
                                         conditionalPanel('input.chSel == "Contour Plots"',
                                                          conditionalPanel('input.chSel2 == "Volcano"',
                                                                           tags$b('In this section, we will use an embedded dataset named Volcano. It is a matrix containing 87 rows and 61 columns.'),
                                                                           br(),
                                                                           br(),
                                                                           tags$strong('R Code: '),
                                                                           uiOutput('CPCode1'), #volcano code
                                                                           br(),
                                                                           plotlyOutput('plotly3') #volcano plot
                                                          ),
                                                          conditionalPanel('input.chSel2 == "Protein-Protein Interaction"',
                                                                           plotOutput('proteinInt')
                                                                           )
                                                          
                                         ),
                                         
                                         conditionalPanel('input.chSel == "Heatmaps"',
                                                          conditionalPanel('input.heat1 == "Volcano"',
                                                                           tags$strong('R Code: '),
                                                                           uiOutput('CPCode2'),
                                                                           br(),
                                                                           plotlyOutput('plotly4')
                                                                           ),
                                                          conditionalPanel('input.heat1 == "Cars"',
                                                                           plotlyOutput('cars1')
                                                                           )
                                         )
                                         )
                                   )
                                 )
                        )#, comment a , here
                        # 
                        # tabPanel('Mosaic Plots'),
                        # 
                        # tabPanel('Bar Graph & Histogram')
            )
            )
    
    )
)

shinyUI(dashboardPage(skin = 'green', header, sidebar, body))