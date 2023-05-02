source("R/train-test-split.R")

set.seed(1234)
rf <- train(
  x = X_train,
  y = Y_train,
  method = "rf",
  ntree = 500,
  tuneGrid = data.frame(mtry = c(floor(ncol(X_train))/3, floor(ncol(X_train))/2)),
  trControl = trainControl(method = "CV", number = 3, verboseIter = T)
)

