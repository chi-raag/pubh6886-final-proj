library(rhdf5)
library(dplyr)

group_names <- h5ls("data/Dataset.h5", recursive = 1)$name
time_vec <- c()
df <- tibble(
  "sample" = character(),
  "metabolite" = character(),
  "rt" = numeric(),
  "mz" = numeric(),
  "left_win" = numeric(),
  "right_win" = numeric()
)
int_times <- list()

for (name in group_names) {
  sample <- h5read("data/Dataset.h5", name)
  metabolites <- names(sample)
  i = 1
  int_times[[name]] <- list()
  for (metabolite in sample) {
    int <- metabolite$Intensities
    rt <- metabolite$RT
    times <- metabolite$Times |> round(3)
    win <- metabolite$Window
    mz <- metabolite$mz
    time_vec <- time_vec |> append(times)
    df <- df |>
      bind_rows(
        tibble(
          "sample" = name,
          "metabolite" = metabolites[i],
          "rt" = rt,
          "mz" = mz,
          "left_win" = win[1],
          "right_win" = win[2]
        )
      )
    int_times[[name]][[metabolites[i]]] <-
      tibble("times" = times, "int" = int)
    i <- i + 1
  }
}

unique_times <- unique(time_vec)
h5closeAll()

time_colnames <- paste0("time_", 1:length(unique_times))
int_time_df <-
  setNames(data.frame(matrix(
    ncol = length(unique_times), nrow = 0
  )), time_colnames)

for (i in 1:length(int_times)) {
  for (j in 1:length(int_times[[i]])) {
    if (length(int_times[[i]]) == 0) {
      next
    }
    ints <- full_join(int_times[[i]][[j]],
                      tibble("times" = unique_times), by = "times") |>
      pull(int)
    ints[is.na(ints)] <- 0
    names(ints) <- time_colnames
    int_time_df <- int_time_df |>
      bind_rows(ints)
    }
}

full_df <- bind_cols(df, int_time_df)
data.table::fwrite(full_df, "data/data.csv.gz")
