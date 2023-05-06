library(caret)
library(glmnet)
library(dplyr)

full_data <- data.table::fread("data/data.csv.gz") |>
  as_tibble()

X <- full_data |>
  select(-sample, -metabolite, -left_win, -right_win) |>
  as.matrix()

nzv <- nearZeroVar(X)
X <- X[, -nzv]

pre_proc <- preProcess(X,
           method = c("nzv", "center", "scale", "YeoJohnson"))

X <- predict(pre_proc, X)


Y_left <- full_data |>
  pull(left_win)
Y_right <- full_data |>
  pull(right_win)
