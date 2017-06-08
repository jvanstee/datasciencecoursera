##Downloading and unzipping dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to ./data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Using data.table and dplyr packages for this project.
library(data.table)
library(dplyr)

##Read training data
TrainingSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
TrainingActivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
TrainingData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

##Read test data
TestSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
TestActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
TestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)

##Merge training and test sets
subject <- rbind(TrainingSubject, TestSubject)
activity <- rbind(TrainingActivity, TestActivity)
data <- rbind(TrainingData, TestData)

##Read the names of the data and the activities from the features.txt and activity_labels.txt data sets
DataNames <- read.table("./data/UCI HAR Dataset/features.txt")
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Naming the columns
## the columns in the data table are obtained are derived from the features.txt dataset
colnames(data) <- t(DataNames[2])
## the column names for the subject and activity table are set by me
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"

## Merge and store in completeData
completeData <- cbind(subject,activity,data)

##Extract the column indices that have either mean or std in them.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

##Add activity and subject columns to the list and look at the dimension of completeData
requiredColumns <- c(1,2,columnsWithMeanSTD)

##create extractedData with the selected columns in requiredColumns. And again, we look at the dimension of requiredColumns.
extractedData <- completeData[,requiredColumns]

##create descriptive activity names to name the activities in the data set
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

##We need to factor the activity variable, once the activity names are updated.
extractedData$Activity <- as.factor(extractedData$Activity)

##Appropriately labels the data set with descriptive variable names
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

##create an independent tidy data set with the average of each activity and subject
##First set Subject as a factor variable.
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

##create tidyData as a data set with average for each activity and subject
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)

##order the enties in tidyData and write it into data file Tidy.txt that contains the processed data
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, "tidyData", row.name=FALSE)

