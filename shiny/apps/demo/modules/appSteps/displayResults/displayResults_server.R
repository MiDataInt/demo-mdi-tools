#----------------------------------------------------------------------
# displayResults appStep server function
#----------------------------------------------------------------------
displayResultsServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
        ns <- NS(id) # in case we create inputs, e.g. via renderUI
        module <- 'displayResults' # for reportProgress tracing
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# initialize settings and other step-level links
#----------------------------------------------------------------------
settings <- activateMdiHeaderLinks(
    session,
    baseDirs = getAppStepDir(module),    
    envir = environment(),
    settings = id
)

#----------------------------------------------------------------------
# initialize data source selection via a table
#----------------------------------------------------------------------
sourceId <- dataSourceTableServer(
    id = 'select'
)
myMtCars <- reactive({ # the R mtcars data set, sent to us via the demo pipeline
    sourceId <- sourceId() # the table selection
    req(sourceId)
    x <- getSourceFilePath(sourceId, 'dataFrame') %>% fread # read the pipeline file
    updateSelectInput(session, 'xAxisCol', choices = names(x)) # update the plot axis selectors
    updateSelectInput(session, 'yAxisCol', choices = names(x))
    x # return the tabular data
})

#----------------------------------------------------------------------
# render output elements
#----------------------------------------------------------------------

# data table
output$mtcars <- renderDT({
    myMtCars()
})

# correlation plot with selectable axis and point color setting
output$plot <- renderPlot({
    d <- myMtCars()
    req(d)
    req(input$xAxisCol)
    req(input$yAxisCol)
    plot(
        d[[input$xAxisCol]], 
        d[[input$yAxisCol]],
        xlab = input$xAxisCol,
        ylab = input$yAxisCol,
        pch = 19,
        col = settings$get('Plot_Options', 'Point_Color')
    ) 
})

# text output of file listing, as executed by the demo pipeline
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
# render additional output elements using MDI widget boxes
#----------------------------------------------------------------------
staticPlot <- staticPlotBoxServer(
    "staticPlotBox",
    points  = TRUE,
    margins = TRUE,
    title   = TRUE,
    baseDirs = getAppStepDir(module),
    immediate = TRUE,
    size = "m",
    create = function() {
        d <- myMtCars()
        req(d)
        xcol <- input$xAxisCol
        ycol <- input$yAxisCol
        req(xcol)
        req(ycol)
        x <- d[[xcol]]
        y <- d[[ycol]]
        staticPlot$initializeFrame(
            xlim = range(x),
            ylim = range(y),
            xlab = xcol,
            ylab = ycol
        )
        staticPlot$addPoints(
            x = x,
            y = y,
            col = settings$get('Plot_Options', 'Point_Color')
        )
    }
)
xyData <- reactive({
    data.frame( # TODO: ip should handle this (needs to call as.data.table())
        x = 1:4,
        y = 1:4
    )
})
interactivePlotBoxServer(
    'interactivePlotBox', 
    type = "scatter",
    baseDirs = getAppStepDir(module),
    plotData = xyData
)

# interactiveScatterplotServer(
#     'interactivePlot',
#     plotData = xyData
 
#     # mode = "markers",
#     # color = NA,
#     # symbol = NA,   
#     # pointSize = 3,
#     # lineWidth = 2,

#     # xtitle = "x",
#     # xrange = NULL,
#     # xzeroline = TRUE,
#     # ytitle = "y",
#     # yrange = NULL,
#     # yzeroline = TRUE,

#     # selectable = FALSE,
#     # clickable  = FALSE,


#     # fitMethod = NULL, 
#     # fitColor = NA,

# )

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
