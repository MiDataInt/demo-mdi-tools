#----------------------------------------------------------------------
# withCode appStep server function
#----------------------------------------------------------------------
withCodeServer <- function(id, options, bookmark, locks) { # always follow this pattern
    moduleServer(id, function(input, output, session) {
        ns <- NS(id) # in case we create inputs, e.g. via renderUI
        module <- 'withCode' # for reportProgress tracing
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# initialize data source selection via a table
#----------------------------------------------------------------------
sourceId <- dataSourceTableServer(
    id = 'select'
)

#----------------------------------------------------------------------
# render output elements
#----------------------------------------------------------------------

# text output of file listing, as executed by the demo pipeline
output$ls <- renderText({
    sourceId <- sourceId()
    req(sourceId)
    paste(
        getSourcePackageOption(sourceId, "demo", "input-dir"), # --input-dir option to demo:do
        slurpFile( getSourceFilePath(sourceId, 'directoryContents') ), # contents of the file created by demo:do
        sep = "\n"
    )
})

#----------------------------------------------------------------------
# initialize the code viewer(s)
#----------------------------------------------------------------------
codeViewerServer(
    id = 'codeViewer',  
    parentId = id
)
codeViewerModalServer(
    id = 'lsScript',  
    parentId = id,  
    codeFile = file.path(gitStatusData$suite$dir, 'pipelines', 'demo', 'do', 'ls', 'ls.sh')
)

#----------------------------------------------------------------------
# module return values go here (if none, use NULL instead of a list)
#----------------------------------------------------------------------
NULL

#----------------------------------------------------------------------
})}
