source("R/train-test-split.R")

l2_fit <- glmnet(X_train, Y_train, alpha = 1)
l2_fit_tune <- data.frame(alpha = 1, lambda = l2_fit$lambda)

set.seed(1234)
l2_fit_cv <- train(
  x = X_train,
  y = Y_train,
  method = "glmnet",
  tuneGrid = l2_fit_tune,
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

l2_fit_cv

Y_hat <- predict(l2_fit_cv$finalModel, X_test, s = l2_fit_cv$bestTune$lambda)

RMSE(Y_hat, Y_test)

plot(Y_hat - Y_test)
