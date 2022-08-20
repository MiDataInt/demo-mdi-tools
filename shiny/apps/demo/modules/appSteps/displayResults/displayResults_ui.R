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
            width = 6, 
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

        # display the file listing from the demo pipeline, and enable a reactive plot
        fluidRow(
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 5,
                title = "Correlation Plot",
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
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 7,
                title = "Directory Listing",
                verbatimTextOutput(ns('ls'))
            )
        ),

        # additional plots using MDI widget boxes
        fluidRow(
            staticPlotBoxUI(
                ns("staticPlotBox"), 
                status = 'primary',
                solidHeader = FALSE,
                width = 6,
                title = "Static Plot Box",
                code = TRUE
            ),
            interactivePlotBoxUI(
                ns('interactivePlotBox'),
                status = 'primary',
                solidHeader = FALSE,
                width = 6,
                title = "Interactive Scatter Plot", 
                code = TRUE,
                type = "scatter"            
            )
        )
    ) 
}
