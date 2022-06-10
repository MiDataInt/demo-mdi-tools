#----------------------------------------------------------------------
# basicTraining appStep server function
#----------------------------------------------------------------------
basicTrainingServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
        ns <- NS(id) # in case we create inputs, e.g. via renderUI
        module <- 'basicTraining' # for reportProgress tracing
#----------------------------------------------------------------------

##################################
# add your server elements here, replacing the code below
##################################
output$randomValue <- renderText({
    input$updateButton
    sample(1e8, 1)
})
##################################

#----------------------------------------------------------------------
# module return values go here (if none, use NULL instead of a list)
#----------------------------------------------------------------------
NULL

#----------------------------------------------------------------------
})}
