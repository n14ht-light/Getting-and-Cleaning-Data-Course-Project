## 1. Merges the training and the test sets to create one data set.

## Load raw data sets
library(plyr)
library(data.table)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)

subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)

## Organise and combinie raw data sets into single one
xDataSet <- rbind(xTrain, xTest)
yDataSet <- rbind(yTrain, yTest)
subjectDataSet <- rbind(subjectTrain, subjectTest)

dim(xDataSet)
dim(yDataSet)
dim(subjectDataSet)

## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement.

## xData subset based on the logical vector to keep only desired columns, i.e. mean() and std()
xDataSet_mean_std <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("./data/UCI HAR Dataset/features.txt")[, 2])]
names(xDataSet_mean_std) <- read.table("./data/UCI HAR Dataset/features.txt")[grep("-(mean|std)\\(\\)", read.table("./data/UCI HAR Dataset/features.txt")[, 2]), 2] 
View(xDataSet_mean_std)
dim(xDataSet_mean_std)

## 3. Uses descriptive activity names to name the activities in the data set
yDataSet[, 1] <- read.table("./data/UCI HAR Dataset/activity_labels.txt")[yDataSet[, 1], 2]
names(yDataSet) <- "Activity"
View(yDataSet)

## 4. Appropriately labels the data set with descriptive variable names.
names(subjectDataSet) <- "Subject"
summary(subjectDataSet)

# Organise and combine all data sets into single one

singleDataSet <- cbind(xDataSet_mean_std, yDataSet, subjectDataSet)

# Define descriptive names for all variables

names(singleDataSet) <- make.names(names(singleDataSet))
names(singleDataSet) <- gsub('Acc',"Acceleration",names(singleDataSet))
names(singleDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(singleDataSet))
names(singleDataSet) <- gsub('Gyro',"AngularSpeed",names(singleDataSet))
names(singleDataSet) <- gsub('Mag',"Magnitude",names(singleDataSet))
names(singleDataSet) <- gsub('^t',"TimeDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('^f',"FrequencyDomain.",names(singleDataSet))
names(singleDataSet) <- gsub('\\.mean',".Mean",names(singleDataSet))
names(singleDataSet) <- gsub('\\.std',".StandardDeviation",names(singleDataSet))
names(singleDataSet) <- gsub('Freq\\.',"Frequency.",names(singleDataSet))
names(singleDataSet) <- gsub('Freq$',"Frequency",names(singleDataSet))

View(singleDataSet)
names(singleDataSet)

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

Data2<-aggregate(. ~Subject + Activity, singleDataSet, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "secTidySet.txt",row.name=FALSE)
