## About source data
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## About R script
File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work):   

1. Merges the training and the test sets to create one data set.
    1.1 Load raw data sets
    1.2 Organise and combinie raw data sets into single one
    
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    2.1 xData subset based on the logical vector to keep only desired            columns, i.e. mean() and std()
    
3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.
    4.1 Organizing and combining all data sets into single one
    4.2 Defining descriptive names for all variables
    
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## About variables:   
* "subjectTrain", "xTrain", "yTrain", "subjectTest", "xTest" and "yTest" contain the data from the downloaded files.

* "xDataSet", "yDataSet" and "subjectDataSet" merge the previous datasets to further analysis.

* "singleDataSet" organises and combines all data sets into a single one.
