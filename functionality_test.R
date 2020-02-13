library(randomForest)
devtools::install_github("https://github.com/jadonwagstaff/randomForestMtry")

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

data(mtcars)
data(imports85)


# Test randomForestMtry functionality
#--------------------------------------------------------------------------------

rf_reg <- randomForest(mpg ~ ., mtcars, mtry = 2)
hist(unique_vars(rf_reg))

rfm_reg <- randomForestMtry::randomForest(mpg ~ ., mtcars, mtry = 2)
all(unique_vars(rfm_reg) <= 2)

imports85 <- imports85[-2]
imports85 <- imports85[complete.cases(imports85),]

rf_class <- randomForest(symboling ~ ., imports85, mtry = 2)
hist(unique_vars(rf_class))

rfm_class <- randomForestMtry::randomForest(symboling ~ ., imports85, mtry = 2)
all(unique_vars(rfm_class) <= 2)


