#Set working directory to unzip folder directory
getwd()

#Load libraries
library(dplyr)
library(magrittr)

#Read datasets

##Read features and activities dataset
features <- read.table("features.txt", col.names = c("n","functions"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))

##Read test dataset
test_x <- read.table("test/X_test.txt", col.names = features$functions)
test_y <- read.table("test/y_test.txt", col.names = "code")
test_subject <- read.table("test/subject_test.txt", col.names = "subject")

##Read train variables
train_x <- read.table("train/X_train.txt", col.names = features$functions)
train_y <- read.table("train/y_train.txt", col.names = "code")
train_subject <- read.table("train/subject_train.txt", col.names = "subject")

#Step 1: Merges the training and the test sets to create one data set
table_x <- rbind(train_x, test_x)
table_y <- rbind(train_y, test_y)
table_subject <- rbind(test_subject, train_subject)
table_merged <- cbind(table_subject, table_x, table_y)

#Step 2:Extracts only the measurements on the mean and standard deviation for each measurement
table_merged %<>% 
  select(subject, code, contains("mean"), contains("std"))

#Step 3: Uses descriptive activity names to name the activities in the data set.
table_merged$code <- activities[table_merged$code, 2]

#Step 4: Appropriately labels the data set with descriptive variable names.
names(table_merged)[2] = "activity"
names(table_merged)<-gsub("Acc", "Accelerometer", names(table_merged))
names(table_merged)<-gsub("Gyro", "Gyroscope", names(table_merged))
names(table_merged)<-gsub("BodyBody", "Body", names(table_merged))
names(table_merged)<-gsub("Mag", "Magnitude", names(table_merged))
names(table_merged)<-gsub("^t", "Time", names(table_merged))
names(table_merged)<-gsub("^f", "Frequency", names(table_merged))
names(table_merged)<-gsub("tBody", "TimeBody", names(table_merged))
names(table_merged)<-gsub("-mean()", "Mean", names(table_merged), ignore.case = TRUE)
names(table_merged)<-gsub("-std()", "STD", names(table_merged), ignore.case = TRUE)
names(table_merged)<-gsub("-freq()", "Frequency", names(table_merged), ignore.case = TRUE)
names(table_merged)<-gsub("angle", "Angle", names(table_merged))
names(table_merged)<-gsub("gravity", "Gravity", names(table_merged))

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
grouped_table <- table_merged %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(grouped_table, "step5_table.txt", row.name=FALSE)
