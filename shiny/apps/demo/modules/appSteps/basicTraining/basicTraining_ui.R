#----------------------------------------------------------------------
# basicTraining appStep ui function
#----------------------------------------------------------------------
basicTrainingUI <- function(id, options) {

    # initialize namespace
    ns <- NS(id)
    
    # override missing options to defaults
    options <- setDefaultOptions(options, stepModuleInfo$basicTraining)

    # return the UI contents
    standardSequentialTabItem(
        HTML(paste( 
            options$longLabel, 
            if(!serverEnv$IS_SERVER) rConsoleLink(ns('console')) else "",
            aceEditorLink(ns('code')) 
        )),

        ##################################
        # add your UI elements here, replacing the code below
        ##################################
        actionButton(ns('updateButton'), 'Generate Random Value'),        
        textOutput(ns('randomValue')),
        tags$hr(),
        tags$p("add additional UI elements to: apps/demo/modules/appSteps/basicTraining/basicTraining_ui.R"),
        tags$p("add additional server elements: to apps/demo/modules/appSteps/basicTraining/basicTraining_server.R")
        ##################################
    ) 
}
