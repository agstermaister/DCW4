### Data-Cleaning-Week-4-Assignment
---
title: "README"

author: "Agnes Eordogh"

date: "2024-02-04"

output: html_document

---
# Getting and Cleaning Data Course Project
* [Summary](#summary)
* [Repository Contents](#contents)
* [Key Concepts from Getting and Cleaning Data](#concepts)
* [The process](#process)

<h1 id=summary>Summary </h1>
The purpose of Getting and Cleaning Data Course Project is to demonstrate one's ability to create a tidy dataset to be used for analysis by collecting and cleaning the provided data sets. 
The data provided by the course website represent data collected from the accelerometers from Samsung Galaxy S smartphones. A full description is available at the link below:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
The data provided by the course is available below:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The  repository includes xx files that can be used to read and cean the data provided for further analysis. The repository includes the tidy data in txt format, the run_analysis file that includes all the scripts to prepare the data. Additional files in the repository include the README.md and CodeBook.md and images that are referenced within the README.

<h1 id=contents>Repository Contents</h1>

<table>
<tr><th>File Name</th><th>Description</th></tr>
<tr><td valign=top>README.md</td><td>Documentation explaining the project and how to use files contained in the repository.</td></tr>
<tr><td valign=top>run_analysis.R</td><td>R script to read, clean and transform the Human Activity Recognition Using Smartphones data  The scripts used are detailed in [The process](#process) section.</td></tr>
<tr><td valign=top>tidy data.txt</td><td>Txt file, the data achieved after reading and cleaning and transformation</td></tr>       
<tr><td valign=top>*.png</td><td>Graphics images to be embedded in the README.md file</td></tr>
<tr><td valign=top>CodeBook.md</td><td>Local copy of codebook describing the tidy data file layout and the transformations completed.</td></tr>
</table>



<h1 id=concepts>Key Concepts from Getting and Cleaning Data Course Project</h1>
The course focused on ... principles that shoudl were employed in the handling of data


<h1 id=process>The Process</h1>

To get the daataframe required i followed the steps below. The order is a bit different then listed on the task. As I found it more practical to add the descriptive variable names before filtering for mean and standard deviation.
#pic

After loading the dplyer package and imported the files (features.txt, subject_test.txt,y_test.txt, x_test.txt, subject_train.txt,y_train.txt, x_train.txt) first I combined the train dataset and test data sets separately and then combined the 2 datasests together. 


<h3> Load dplyer package </h3>

```{r}
library(dplyr)
```

<h3>  Import features.txt to use as column headers </h3>h3> 

```{r}
features <- read.table("features.txt", sep = "\t")
```

<h3>  Read training and test datasets first chnaging the directory to test sub-folder then from the test folder </h3> 

```{r}
current_dir <- getwd()
test_folder_name <- "test"
training_folder_name <- "train"
test_path <- file.path(current_dir, test_folder_name )
```

<h3>  Set the working directory to the "test" folder </h3>

```{r}
setwd(test_path)
```

<h3>  Read data from the "test" folder </h3>

```{r}
test_subject_data <- read.table("subject_test.txt", header = FALSE, sep = "\t")
test_y_data <- read.table("y_test.txt", sep = "\t")
test_x_data <- read.table("X_test.txt", sep = "\t")
```

<h3>  Combine test data </h3>

```{r}
combined_test_data <- cbind(test_subject_data, test_y_data,test_x_data)
```

<h3>  Switch back to the original working directory </h3>

```{r}
setwd(current_dir)
```

<h3>  Set the working directory to the "train" folder </h3> 

```{r}
trainign_path <- file.path(current_dir, training_folder_name)
setwd(trainign_path)

train_subject_data <- read.table("subject_train.txt", header = FALSE, sep = "\t")
train_y_data <- read.table("y_train.txt", sep = "\t")
train_x_data <- read.table("X_train.txt", sep = "\t")
```


<h3>  Combine training data </h3>

```{r}
combined_train_data <- cbind(train_subject_data, train_y_data,train_x_data)
```


<h3>  Combine training and test datasets </h3>

```{r}
combined_df <- rbind(combined_test_data, combined_train_data)
new_col_names <- c("Subject ID", "Activity", "Measures")
colnames(combined_df) <- new_col_names
```

<h3>  Remove double space from measure and split on space so eache measurement are in a separate column </h3>

```{r}
combined_df$Measures <- gsub("\\s+", " ", combined_df$Measures)
split_names <- do.call(rbind, strsplit(as.character(combined_df$Measures), " "))
combined_df <- cbind(combined_df, split_names)
```


<h3>  Use descriptive activity names to name the activities in the data set </h3>

```{r}
col_names2 <- features$V1
col_names <- c(new_col_names,"blank",col_names2)
colnames(combined_df) <- col_names
```


<h3>  Keep only the mean and standard deviation for each measurement </h3>

```{r}
short_combined_df <- combined_df %>%
        select(matches("Subject ID|Activity|mean|sdv"))
```
        

<h3>  Label the data set with descriptive variable names </h3>

```{r}
short_combined_df <- short_combined_df %>% mutate(Activity = ifelse(Activity == 1, "WALKING", ifelse(Activity == 2, "WALKING_UPSTAIRS", ifelse(Activity == 3, "WALKING_DOWNSTAIRS", ifelse(Activity == 4, "SITTING", ifelse(Activity == 5, "STANDING", "LAYING"))))))
```

<h3>  Create new data set with the average of each variable </h3> 

```{r}
measurements <- colnames(short_combined_df)
measurements <- measurements[-c(1, 2)]
short_combined_df <- short_combined_df  %>%
        mutate(across(all_of(measurements), as.numeric))

mean_df <- short_combined_df %>% 
        group_by(Activity,`Subject ID`) %>%
        summarise(across(all_of(measurements), mean, .names = "mean_{.col}"))
```



<h3>  Write new tidy dataset to main directory </h3> 

```{r}
setwd(current_dir)
write.table(mean_df,"tidy data")
```
