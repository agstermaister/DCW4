
# Load dplyer package
library(dplyr)

# Set directory 
setwd("data")

#Import features.txt to use as column headers
features <- read.table("features.txt", sep = "\t")

# Read training and test datasets
current_dir <- getwd()
test_folder_name <- "test"
training_folder_name <- "train"
test_path <- file.path(current_dir, test_folder_name )

# Set the working directory to the "test" folder
setwd(test_path)

# Read data from the "test" folder
test_subject_data <- read.table("subject_test.txt", header = FALSE, sep = "\t")
test_y_data <- read.table("y_test.txt", sep = "\t")
test_x_data <- read.table("X_test.txt", sep = "\t")
# Combine test data 
combined_test_data <- cbind(test_subject_data, test_y_data,test_x_data)

# Switch back to the original working directory
setwd(current_dir)
# Set the working directory to the "train" folder
training_path <- file.path(current_dir, training_folder_name)
setwd(training_path)

train_subject_data <- read.table("subject_train.txt", header = FALSE, sep = "\t")
train_y_data <- read.table("y_train.txt", sep = "\t")
train_x_data <- read.table("X_train.txt", sep = "\t")

# Combine training data 
combined_train_data <- cbind(train_subject_data, train_y_data,train_x_data)

# Combine training and test datasets
combined_df <- rbind(combined_test_data, combined_train_data)
new_col_names <- c("Subject ID", "Activity", "Measures")
colnames(combined_df) <- new_col_names

# Remove double space from measure and split on space
combined_df$Measures <- gsub("\\s+", " ", combined_df$Measures)
split_names <- do.call(rbind, strsplit(as.character(combined_df$Measures), " "))
combined_df <- cbind(combined_df, split_names)

# Label the data set with descriptive variable names
col_names <- c(new_col_names,"blank",col_names2)
colnames(combined_df) <- col_names

# Keep only the mean and standard deviation for each measurement
short_combined_df <- combined_df %>%
        select(matches("Subject ID|Activity|mean|sdv"))

# Use descriptive activity names to name the activities in the data set
short_combined_df <- short_combined_df %>% mutate(Activity = ifelse(Activity == 1, "WALKING", ifelse(Activity == 2, "WALKING_UPSTAIRS", ifelse(Activity == 3, "WALKING_DOWNSTAIRS", ifelse(Activity == 4, "SITTING", ifelse(Activity == 5, "STANDING", "LAYING"))))))

# Create new data set with the average of each variable
measurements <- colnames(short_combined_df)
measurements <- measurements[-c(1, 2)]

short_combined_df <- short_combined_df  %>%
        mutate(across(all_of(measurements), as.numeric))

mean_df <- short_combined_df %>% 
        group_by(Activity,`Subject ID`) %>%
        summarise(across(all_of(measurements), mean, .names = "mean_{.col}"))

# Write new tidy dataset to main directory
setwd("..")
write.table(mean_df, file = "tidy_data.txt", sep = "\t")
