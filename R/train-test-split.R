library(caret)
library(glmnet)
library(dplyr)

full_data <- data.table::fread("data/data.csv.gz") |>
  as_tibble()

set.seed(1234)
train_data_i <- createDataPartition(full_data$left_win,
                                    times = 1,
                                    p = .9,
                                    list = F)

train_data <- full_data[train_data_i, ]
test_data <- full_data[-train_data_i, ]

X_train <- train_data |>
  select(-sample, -metabolite, -left_win, -right_win) |>
  as.matrix()

nzv <- nearZeroVar(X_train)
X_train <- X_train[, -nzv]

Y_train_left <- train_data |>
  pull(left_win)
Y_train_right <- train_data |>
  pull(right_win)

X_test <- test_data |>
  select(-sample, -metabolite, -left_win, -right_win) |>
  as.matrix()

Y_test_left <- test_data |>
  pull(left_win)

Y_test_right <- test_data |>
  pull(right_win)
