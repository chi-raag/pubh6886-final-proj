source("R/train-test-split.R")

tune_grid <- expand.grid(
  alpha = seq(0, 1, by = .1),
  lambda = seq(0, 3, by = .001)
)

set.seed(1234)
ridge_left_fit_cv <- train(
  x = X,
  y = Y_left,
  method = "glmnet",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

ridge_left_fit_cv$bestTune
ridge_left_fit_cv$results[9013, ]

set.seed(1234)
ridge_right_fit_cv <- train(
  x = X,
  y = Y_right,
  method = "glmnet",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "cv",
    number = 10,
    selectionFunction = "best"
  )
)

ridge_right_fit_cv$bestTune
ridge_left_fit_cv$results[27015, ]
