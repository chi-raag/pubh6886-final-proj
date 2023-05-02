source("R/train-test-split.R")

en <- glmnet(X_train, Y_train, alpha = 0.5)

en_tune <- data.frame(alpha = .5, lambda = en$lambda)

set.seed(1234)
en_cv <- train(
  x = X_train,
  y = Y_train,
  method = "glmnet",
  tuneGrid = en_tune,
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

Y_hat <- predict(en_cv$finalModel, X_test, s = en_cv$bestTune$lambda)

RMSE(Y_hat, Y_test)

plot(Y_hat - Y_test)

