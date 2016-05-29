#1.import activity label and features tables
activity_labels <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")
features <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt")

#2.filter mean and standard deviation from feature list
features_mean_std_name <- features$V2[grepl(".*mean.*|.*std.*",features$V2)]
features_mean_std_name <- as.character(features_mean_std_name)

#3.1 import x_train data
features_vector <- as.character(features$V2)
length(features_vector)
X_train <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
head(X_train)
ncol(X_train)
colnames(X_train) <- features_vector
head(X_train)

#3.2 combine train data
y_train <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
colnames(y_train) <- "train_activity"
subject_train <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
colnames(subject_train) <- "train_subject"
nrow(X_train)
nrow(y_train)
nrow(subject_train)
train_data <- cbind(subject_train, y_train, X_train)
head(train_data)

#4.1 import x_test data
X_test <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
head(X_test)
ncol(X_test)
colnames(X_test) <- features_vector
head(X_test)

#4.2 combine test data
y_test <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
colnames(y_test) <- "test_activity"
subject_test <- read.table("E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
colnames(subject_test) <- "test_subject"
nrow(X_test)
nrow(y_test)
nrow(subject_test)
test_data <- cbind(subject_test, y_test, X_test)
head(test_data)

#5. combine test and train data
colnames(test_data)[1] <- "subject"
colnames(test_data)[2] <- "activity"
colnames(train_data)[1] <- "subject"
colnames(train_data)[2] <- "activity"
WholeData <- rbind(train_data, test_data)
selectcol <- c("subject", "activity", features_mean_std_name)
WholeData_mean_std <- WholeData[,selectcol]

#6. creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
subject_activity_mean <- WholeData_mean_std %>% group_by(subject, activity) %>% summarize_each(funs(mean))

#7. export dataset into csv file
write.table(WholeData_mean_std, "E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\WholeData_mean_std.txt")
write.table(subject_activity_mean, "E:\\academic development\\Data Scientist\\Data Science - Johns Hopkins University (Coursera)\\Course 3 Getting and Cleaning Data\\Week 4\\Project\\subject_activity_mean.txt")
