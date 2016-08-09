# Getting and cleaning data - Peer graded test

The dataset used in this program was obtained in the follow link [Recognition using smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
This program has the purpose to obtain the grade to the coursera "Getting and Cleaning Data" course.

## Steps to run the software

This file describe the steps to tidy the data collected of the movements of sensors from Smartphones.

1. Have installed properly the software R and the dplyr library.
2. Clone the [GitHub repository](https://github.com/schmittjoaopedro/getting-and-cleaning-data) on your computer
3. Start the R software, copy the path of the directory where this github repository was cloned
3. Using setwd() command, define the directory copied in step 2.
4. Check your directory access to write operations (permission to write)
5. Load and run the script run_analysis.R with the command: 
    ```R
    source("run_analysis.R")
    ```

Note: If the download is slow, you can copy the file of this dataset and paste in the same directory of the "run_analysis.R" with the name data.zip.

# What the script *run_analysis.R" makes

1. Download the dataset of the site.
2. Loads the features.txt and normalize their values
3. Filter only mean and std values of the features.txt
4. Loads the values of the mean and std of the training and test of the datasets X
5. Merges the training and test datasets of X with the datasets of Y and customers
6. Replace the activity Id by the activity label
7. Calculates the mean of the values of each column for each group
8. Writes the calculated dataset in a file called tidy_data.txt

Author: João Pedro Schmitt