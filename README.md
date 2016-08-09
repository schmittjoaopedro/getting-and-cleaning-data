# Getting and cleaning data - Peer graded test

## Steps to run the software

This file describe the steps to tidy the data collected of the movements of sensors from Smartphones.

1. Have installed properly the software R and the dplyr library.
2. So start the R software, copy the path of the directory where this github repository was cloned
3. Using setwd() command, define the directory copied in step 2.
4. Check your directory access to write operations (permission to write)
5. Load and run the script run_analysis.R with the command: 
    ```R
    source("run_analysis.R")
    ```

# What the script *run_analysis.R" makes

- First the script load the features.txt and normalize their values
- After the script filter only mean and std values of the features.txt
- So the script loads the values of the mean and std of the training and test of the datasets X
- Then the script merges the training and test datasets of X with the datasets of Y and customers
- So the script replace the activity Id by the activity label
- Then the script calculates the mean of the values of each column for each group
- Finally the script writes the calculated dataset in a file called tidy_data.txt

Author: João Pedro Schmitt