library(randomForest)
data(mtcars)

unique_vars <- function(rf) {
  lengths <- rep(as.numeric(NA), rf$ntree)
  for (i in 1:rf$ntree) {
    # Split var from getTree shows variables to split on,
    # so if the splits are all from the same variables,
    # the number of unique variables should be <= mtry.
    # Note that split var is 0 at a leaf, hence the - 1.
    lengths[i] <- length(unique(getTree(rf, i)[,3])) - 1
  }
  return(lengths)
}

rf <- randomForest(mpg ~ ., mtcars, mtry = 2)
hist(unique_vars(rf))

rfm <- randomForestMtry::randomForest(mpg ~ ., mtcars, mtry = 2)
all(unique_vars(rfm) <= 2)
