library(readr)
library(dplyr)

x <- 1:4
y <- 2:3
x+y

quiz_dataset <- read_csv("datasets_coursera/R_programming/week_1/hw1_data.csv")

quiz_dataset[47,1]


number_na <- sum(!complete.cases(quiz_dataset$Ozone))
number_na

#na.rm = TRUE for removing missing values 
mean_ozone <- mean(quiz_dataset$Ozone, na.rm = TRUE)
mean_ozone

#Question 18 Extract the subset of rows of the data frame where Ozone values 
#are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?
mean_ozone_31_90 <- quiz_dataset %>%
  filter(Ozone>31 & Temp > 90)
mean_ozone_31_90
mean(mean_ozone_31_90$Solar.R)

#Question 19_What is the mean of "Temp" when "Month" is equal to 6? 
mean_temp_6 <- quiz_dataset %>%
  filter(Month==6)
mean_temp_6
mean(mean_temp_6$Temp)

#Question 20 What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?
max_ozone_may <- quiz_dataset %>%
  filter(Month==5)
print(max_ozone_may, n=31)
