#
# Author: João Pedro Schmitt
#
# Script used to load raw data from measurements of smartphones and 
# tidy the data and calculate the mean and std for each group formed by
# acvitity and customers
#
# Available at: https://github.com/schmittjoaopedro/getting-and-cleaning-data
#


# Import the required libraries
library(dplyr)



# STEP 1 - OBTAIN THE FILES
# ==========================================================================================================================
# Create util variables
fileName <- "data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataPath <- "UCI HAR Dataset"

# Manage dataset folders and files
if(!file.exists(fileName)) {
    download.file(url = fileURL, destfile = fileName, method = "curl")
}

# Unzip the downloaded file
if(!file.exists(dataPath)) {
    unzip(zipfile = fileName)
}




# STEP 2 - LOAD AND PREPARE THE RAW DATASET
# ==========================================================================================================================

# Load the activity_labels
activitylabels <- read.table(file.path(dataPath,"activity_labels.txt"), col.names = c("activityId","activityName"))

# Load the features, extract only the means and std values of the data set and normallize the names of the measurements
features <- read.table(file.path(dataPath, "features.txt"), col.names = c("featureId","featureCode"))
featuresToSelect <- grepl(".mean.|.std.", features$featureCode) # Extract only the names with mean or std
features <- features[featuresToSelect,2] # Select the labels
features <- gsub("[()]|-","",gsub("mean","Mean",gsub("std", "Std", features))) # Standardize the names

# Load and merge the test and train datasets. Select only the mean and std columns for the dataset of the values,
# and bind columns of activity, subjects and values
# Do only for test
testY <- read.table(file.path(dataPath, "test", "y_test.txt")) # Load activity
testX <- read.table(file.path(dataPath, "test", "X_test.txt"))[,featuresToSelect] # Load values of mean and std
testSub <- read.table(file.path(dataPath, "test", "subject_test.txt")) # Load subjects
testData <- cbind(testY, testSub, testX) # Bind the columns
# Do only for train
trainY <- read.table(file.path(dataPath, "train", "y_train.txt")) # Load activity
trainX <- read.table(file.path(dataPath, "train", "X_train.txt"))[,featuresToSelect] # Load values of mean and std
trainSub <- read.table(file.path(dataPath, "train", "subject_train.txt")) # Load subjects
trainData <- cbind(trainY, trainSub, trainX) # Bind the columns

# Merge train and test datasets
dataset.raw <- rbind(testData, trainData)
# Rename the column names
names(dataset.raw) <- c("activityId","featureCode", features)

# Add activity label instead use the id of activity, by merging
dataset.raw <- merge(activitylabels, dataset.raw, by = "activityId")




# STEP 3 - PROCESS THE TIDY DATASET PRODUCED BY STEP 2
# ==========================================================================================================================
# Exclude the activityId column, group all data by activityName and featureCode and calulate the mean 
# for the values of each group
dataset.tidy <- dataset.raw %>% 
    select(-(activityId)) %>% 
    group_by(activityName, featureCode) %>% 
    summarise_each(funs(mean))

# Create a file with the tidy data
write.table(dataset.tidy, "tidy_data.txt", row.names = F)
