#----------------------------------------------------------------------
# basicTraining appStep server function
#----------------------------------------------------------------------
basicTrainingServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
        module <- 'basicTraining' # for reportProgress tracing
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
# add your server elements here, replacing the code below
#----------------------------------------------------------------------
output$randomValue <- renderText({
    input$updateButton
    sample(1e8, 1)
})
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# module return values go here (if none, use NULL instead of a list)
#----------------------------------------------------------------------
NULL

#----------------------------------------------------------------------
})}
