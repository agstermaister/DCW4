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

<h1 id=summary>Problem Summary </h1>
The  repository includes xx files that can be used to read the data from xx. The xx includes extensive documentation, ranging from code books to user notes and errata. A complete inventory of all available PUMS data is also available on the U.S. Census Bureau website. Additional files in the repository include the README.md and CodeBook.md and images that are referenced within the README.

<h1 id=contents>Repository Contents</h1>

<table>
<tr><th>File Name</th><th>Description</th></tr>
<tr><td valign=top>README.md</td><td>Documentation explaining the project and how to use files contained in the repository.</td></tr>
<tr><td valign=top>read PUMS codebook.R</td><td>R script to read the American Community Survey Public Use Microdata Sample codebook and a single state's data. The codebook is distributed as a Microsoft Excel spreadsheet. The ACS survey data read is the output from the split PUMS person and households.R script. The script uses <code>read.fwf()</code> to read the survey data. </td></tr>
<tr><td valign=top>read PUMS codebook - readr version.R</td><td>R script to read the American Community Survey Public Use Microdata Sample codebook and a single state's data. The codebook is distributed as a Microsoft Excel spreadsheet. The ACS survey data read is the output from the split PUMS person and households.R script. The script uses Hadley Wickham's <code>readr</code> package <code>read_fwf()</code> function to read the survey data.</td></tr>
<tr><td valign=top>split PUMS person and households.R</td><td>R script to parse the census file and separate into two files for downstream processing: a person-level file and a household-level file. The script uses <code>readLines()</code> and <code>substr()</code> to split the data into the appropriate output files. </td></tr>
<tr><td valign=top>*.png</td><td>Graphics images to be embedded in the README.md file</td></tr>
<tr><td valign=top>data/5%_PUMS_record_layout.xls</td><td>Local copy of codebook describing the PUMS data file layout.</td></tr>
</table>





| File Name      | Description |
| :--------      | :---------- |
| README.md      | Documentation explaining the project and how to use files contained in the repository.            |
| CodeBook.md    |             |
| run_analysis.R |             |
| tidy data.txt  |             |        

<h1 id=concepts>Key Concepts from Getting and Cleaning Data</h1>
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
