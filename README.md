##Getting and Cleaning Data - Course Project

#Steps to reproduce

1. Download the zip file from the url in the working directory
2. unzip the data files in the default folder "UCI HAR Dataset"
3. Source the run_analysis.R
4. run the code using source("run_analysis.R")in working directory  
5. it will generate the tidy data in the working dir


# Steps in the code
1. Download the master data
2. read the training data and merge into one file
3. read the testing data and merge into one file
4. merge and clean training and testing data
5. keep only the wanted column names
6. rename the columns to meaning ful names
7. aggregate the data and write it to the file