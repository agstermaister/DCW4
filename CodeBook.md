### Data-Cleaning-Week-4-Assignment
---
title: "CodeBook"

date: "2024-03-16"

author: "Agnes Eordogh"

---

# Getting and Cleaning Data Course Project Codebook
* [Study Design](#design)
* [Raw data](#raw)
* [Transformations](#transformations)
* [Tidy data](#tidy)
* [The Codebook](#codebook)


<h1 id=design>Study Design</h1>

The data used is data collected from accelerometers from the Samsung Galaxy S smartphone by Human Activity Recognition Using Smartphones project by Smartlab. 

There were 30 volunteers involved (19-48 years old). Each performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) whilst wearing a smartphone (Samsung Galaxy S II) on the waist equipped with accelerometer and gyroscope.  They captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded and the data manually labelled. The obtained dataset has been randomly divided into two sets, 70% training data and 30% test data. 

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 

The data was downloaded from the Coursera website:

 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

<h1 id=raw>Raw data</h1> 

The dataset has been randomly divided into two sets, 70% training data and 30% test data. 
The files from the original data being used are listed below.

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

<h1 id=transformations>Transformations</h1>

After reading in both the training and and test data sets (subject_test.txt, y_test.txt, X_test.txt,subject_train.txt,y_train.txt, X_train.txt), first the training sets then the test sets were combined to include the id number, activity and the measurements for each.  The two merge datasets  then were combined into one to include both he training and the test dataset. Column names were added to the data frame for easier understanding. The  column including the Measurements was split to have each measurement in a separate column. The features.txt file was read and the values were used to give the descriptive names to the columns. A new dataframe was created keeping only the columns that include in their column name either of the following texts: "Subject ID", "Activity", "mean" or "sdv". The numeric values of the Activity tables were changed to descriptive values according to activity_labels.txt file. All measurement value types were changed to numeric and the final dataset created by taking the average of each variable for each activity and each subject.

<h1 id=tidy>Tidy data</h1>

The final data set is in wide format and includes 180 records (for each activity and participant) and 55 columns inlcuding the activity, particpant number and 53 columns of the average of the mean and and standard deviation measurements for each activity and participant

 
<h1 id=codebook>The Codebook</h1>

Here is the list of variables used in the final data set with the position, data type, possible value and a short description.


![Codebook](https://github.com/agstermaister/Data-Cleaning-Week-4-Assignment/blob/ab684e76480ca5f5889ad17b6ffcce3cdfd28f95/Codebook.png)


