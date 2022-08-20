#----------------------------------------------------------------------
# displayResults appStep server function
#----------------------------------------------------------------------
displayResultsServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# initialize appStep settings and other step-level links
#----------------------------------------------------------------------
module <- 'displayResults' # for reportProgress tracing
settings <- activateMdiHeaderLinks(
    session,
    baseDirs = getAppStepDir(module),    
    envir = environment(),
    settings = id
)
color <- reactive({
    CONSTANTS$plotlyColors[[settings$get('Plot_Options', 'Point_Color')]]
})

#----------------------------------------------------------------------
# initialize data source selection via a table
#----------------------------------------------------------------------
sourceId <- dataSourceTableServer(id = 'select')
myMtCars <- reactive({ # the R mtcars data set, sent to us via the demo pipeline
    sourceId <- sourceId() # the table selection
    req(sourceId)
    x <- getSourceFilePath(sourceId, 'dataFrame') %>% fread # read the pipeline file
    updateSelectInput(session, 'xAxisCol', choices = names(x)) # update the plot axis selectors
    updateSelectInput(session, 'yAxisCol', choices = names(x))
    x # return the tabular data
})

#----------------------------------------------------------------------
# cascade to two columns of data for plotting
#----------------------------------------------------------------------
plotData <- reactive({
    d <- myMtCars()
    req(d)
    req(input$xAxisCol)
    req(input$yAxisCol)
    list(
        val = data.frame(
            x = d[[input$xAxisCol]], 
            y = d[[input$yAxisCol]]
        ),
        col = list(
            x = input$xAxisCol,
            y = input$yAxisCol
        )  
    )
})

#----------------------------------------------------------------------
# render output data table
#----------------------------------------------------------------------
output$mtcars <- renderDT({
    myMtCars()
})

#----------------------------------------------------------------------
# render scatterplot in three ways
#----------------------------------------------------------------------

# display the plot using a custom module
output$plot <- renderPlot({
    d <- plotData()
    req(d)
    plot(
        d$val$x, 
        d$val$y,
        xlab = d$col$x,
        ylab = d$col$y,
        pch = 19,
        col = color()
    ) 
})

# display the plot using the MDI staticPlotBox module
staticPlot <- staticPlotBoxServer(
    "staticPlotBox",
    points  = TRUE,
    margins = TRUE,
    title   = TRUE,
    baseDirs = getAppStepDir(module),
    immediate = TRUE,
    size = "m",
    create = function() {
        d <- plotData()
        req(d)
        staticPlot$initializeFrame(
            xlim = range(d$val$x),
            ylim = range(d$val$y),
            xlab = d$col$x,
            ylab = d$col$y
        )
        staticPlot$addPoints(
            x = d$val$x,
            y = d$val$y,
            col = color()
        )
    }
)

# display the plot using the MDI interactiveScatterPlot module
interactivePlotBoxServer(
    'interactivePlotBox', 
    type = "scatter",
    baseDirs = getAppStepDir(module),
    plotData = reactive({
        plotData()$val
    }),
    pointSize = 6,
    xtitle = reactive({ plotData()$col$x }),
    ytitle = reactive({ plotData()$col$y })
)

#----------------------------------------------------------------------
# render the text output of file listing, as executed by the demo pipeline
#----------------------------------------------------------------------
output$ls <- renderText({
    sourceId <- sourceId()
    req(sourceId)
    paste(
        getSourcePackageOption(sourceId, "demo", "input-dir"),
        slurpFile( getSourceFilePath(sourceId, 'directoryContents') ),
        sep = "\n"
    )
})

#----------------------------------------------------------------------
# define bookmarking actions
#----------------------------------------------------------------------
observe({
    bm <- getModuleBookmark(id, module, bookmark, locks)
    req(bm)
    settings$replace(bm$settings) # renew the user's page settings
})

#----------------------------------------------------------------------
# module return values go here (if none, use NULL instead of a list)
#----------------------------------------------------------------------
list(
    settings = settings$all_ # remember the user's page settings
)

#----------------------------------------------------------------------
})}
