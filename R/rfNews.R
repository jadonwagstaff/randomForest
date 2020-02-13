rfNews <- function() {
    newsfile <- file.path(system.file(package="randomForestMtry"), "NEWS")
    file.show(newsfile)
}
