#----------------------------------------------------------------------
# basicTraining appStep server function
#----------------------------------------------------------------------
basicTrainingServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# initialize the header links
#----------------------------------------------------------------------
module <- "basicTraining"
activateMdiHeaderLinks(
    session,
    url = "https://midataint.github.io/mdi-basic-training/docs/mdi-apps/exercise/",
    baseDirs = getAppStepDir(module),    
    envir = environment()
)

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
