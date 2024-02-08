### Data-Cleaning-Week-4-Assignment
---
title: "CodeBook"

author: "Agnes Eordogh"

date: "2024-02-08"



# Background

The data used is data collected from accelerometers from the Samsung Galaxy S smartphone by Human Activity Recognition Using Smartphones project. 

There were 30 volunteers involved (19-48 years old). Each performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) whilst wearing a smartphone (Samsung Galaxy S II) on the waist equipped with accelerometer and gyroscope.  They captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded and the data manually labelled. The obtained dataset has been randomly divided into two sets, 70%  training data and 30% the test data. 

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 

The data was downloaded from the Coursera website:

 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Raw data 
The obtained dataset has been randomly divided into two sets, 70%  training data and 30% the test data. 
The files from the original data were being used for the analysis
- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set, 651 measurements taken.

- 'train/y_train.txt': Training activity labels (1-6).

- 'test/X_test.txt': Test set, 651 measurements taken.

- 'test/y_test.txt': Test activity labels (1-6).

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample (Training). Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample (Test). Its range is from 1 to 30. 

 
# The Codebook

Here is the list of variables used in the final data set with the position, data type, possible value and a short description.


![Codebook](https://github.com/agstermaister/Data-Cleaning-Week-4-Assignment/assets/131816758/cf5bd674-3d24-433a-bca0-01ff64c0ec68)


# Transformations

After reading in both the training and and test data sets (subject_test.txt, y_test.txt, X_test.txt,subject_train.txt,y_train.txt, X_train.txt) first the training sets then the test sets were combined to include the id number, activity and the measurements for each, then the two datasets were combined into one to include botht he training and the test dataset. Column names were added to the data frame for easier understanding then the Measurements column was split to have each measurement in a separate column. the features.txt file was read and the the values were used to give the descriptive names to the columns. A new dataframe was created keeping only the columns that include in hteir column name either the following texts: "Subject ID", "Activity", "mean" and "sdv". The numeric values of the Activity tables were changed to descriptive values according to activity_labels.txt file. All measurement value types were changed to numeric and the final dataset created by creating the average of each variable for each activity and each subject.

