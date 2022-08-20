#----------------------------------------------------------------------
# displayResults appStep ui function
#----------------------------------------------------------------------
displayResultsUI <- function(id, options) {

    # initialize namespace
    ns <- NS(id)
    
    # override missing options to defaults
    options <- setDefaultOptions(options, stepModuleInfo$displayResults)

    # return the UI contents
    standardSequentialTabItem(
        options$longLabel,
        options$leaderText, 
        id = id,
        code = TRUE,        
        console = TRUE,
        settings = TRUE,

        # select the input data source to display
        dataSourceTableUI(
            ns('select'), 
            title = "Select Demo Data Set", 
            width = 8, 
            collapsible = FALSE
        ),

        # display the data table from the demo pipeline 
        fluidRow(
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 12,
                title = "Data Table",
                DTOutput(ns('mtcars'))
            )
        ),

        # display a scatter plot of two data columns, using three different approaches
        fluidRow(

            # display the plot using a custom module
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 4,
                title = "Custom Code",
                fluidRow(
                    column(
                        width = 6,
                        selectInput(ns('yAxisCol'), 'Y Axis Column', choices = character())
                    ),
                    column(
                        width = 6,
                        selectInput(ns('xAxisCol'), 'X Axis Column', choices = character())
                    )
                ),
                imageOutput(ns('plot'))
            ), 

            # display the plot using the MDI staticPlotBox module
            staticPlotBoxUI(
                ns("staticPlotBox"), 
                status = 'primary',
                solidHeader = FALSE,
                width = 4,
                title = "Static Plot Box",
                code = TRUE
            ),

            # display the plot using the MDI interactiveScatterPlot module
            interactivePlotBoxUI(
                ns('interactivePlotBox'),
                status = 'primary',
                solidHeader = FALSE,
                width = 4,
                title = "Interactive Scatter Plot", 
                code = TRUE,
                type = "scatter"            
            )
        ),

        # display the file listing from the demo pipeline
        fluidRow(
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 8,
                title = "Directory Listing",
                verbatimTextOutput(ns('ls'))
            )
        )
    ) 
}
