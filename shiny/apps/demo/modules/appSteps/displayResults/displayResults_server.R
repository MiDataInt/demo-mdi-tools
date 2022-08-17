#----------------------------------------------------------------------
# displayResults appStep server function
#----------------------------------------------------------------------
displayResultsServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
        ns <- NS(id) # in case we create inputs, e.g. via renderUI
        module <- 'displayResults' # for reportProgress tracing
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# initialize code and R console links
#----------------------------------------------------------------------
moduleEnv <- environment()
observeEvent(input$code, showAceEditor(
    session, 
    baseDirs = file.path(app$DIRECTORY, "modules/appSteps/displayResults"),
    editable = serverEnv$IS_DEVELOPER
))
observeEvent(input$console, showRConsole(session, envir = moduleEnv, label = module))

#----------------------------------------------------------------------
# initialize tab settings, exposed by gear icon click
#----------------------------------------------------------------------
settings <- stepSettingsServer(
    id = 'settings',
    parentId = id
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
