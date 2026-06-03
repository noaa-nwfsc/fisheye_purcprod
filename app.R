# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
options("golem.app.prod" = TRUE)
# run anytime data needs to be refreshed from G drive
source("R/data_processing.R")
prep_data_fun("2026-06-03")
purcprod::run_app() # add parameters here (if any)
