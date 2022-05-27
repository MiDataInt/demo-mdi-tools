#----------------------------------------------------------------------
# withCode appStep ui function
#----------------------------------------------------------------------
withCodeUI <- function(id, options) {

    # initialize namespace
    ns <- NS(id)
    
    # override missing options to defaults
    options <- setDefaultOptions(options, stepModuleInfo$withCode)

    # return the UI contents
    standardSequentialTabItem(
        options$longLabel,
        options$leaderText,

        # select the input data source to display
        dataSourceTableUI(
            ns('select'), 
            title = "Select Demo Data Set", 
            width = 6, 
            collapsible = FALSE
        ),

        # view the 'ls' output from the 'demo' pipeline
        fluidRow(
            box(
                status = 'primary',
                solidHeader = FALSE,
                width = 12,
                title = tags$span("Directory Listing", codeViewerModalUI(ns('lsScript'))),
                verbatimTextOutput(ns('ls'))
            )
        ),

        # interface for viewing the running appStep code
        codeViewerUI(ns('codeViewer'))
    ) 
}
