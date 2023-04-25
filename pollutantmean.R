pollutantmean <- function(directory, pollutant, id_csv) {
  setwd(directory)
  id <- id_csv
  csv_files <- data.frame(read.csv("id.csv"))
  pollutmean <- mean(complete.cases(csv_files$pollutant))
  pollutmean
}

pollutantmean(
  "C:/Users/se_al/Documents/GitHub/datasciencecoursera/coursera/R_programming/week_2/specdata",
  "nitrate",
  023
)
