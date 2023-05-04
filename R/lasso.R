source("R/train-test-split.R")

nzv <- nearZeroVar(X_train)
X_train <- X_train[, -nzv]

l2_left_fit <- glmnet(X_train, Y_train_left, alpha = 1)
l2_left_fit_tune <- data.frame(alpha = 1, lambda = l2_left_fit$lambda)

set.seed(1234)
l2_left_fit_cv <- train(
  x = X_train,
  y = Y_train_left,
  method = "glmnet",
  tuneGrid = l2_left_fit_tune,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

l2_left_fit_cv

l2_right_fit <- glmnet(X_train, Y_train_right, alpha = 1)
l2_right_fit_tune <- data.frame(alpha = 1, lambda = l2_right_fit$lambda)

set.seed(1234)
l2_right_fit_cv <- train(
  x = X_train,
  y = Y_train_right,
  method = "glmnet",
  tuneGrid = l2_right_fit_tune,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

l2_right_fit_cv

RMSE(Y_hat, Y_test)

plot(Y_hat - Y_test)
