run_analysis <- function(){

    #Read the masters and give the names to data frame column
    activities <- read.table("UCI HAR Dataset/activity_labels.txt")
    names(activities) <- c("activityId", "activityName")
    features <- read.table("UCI HAR Dataset/features.txt")
    names(features) <- c("featureId", "featureName")
    
    ##read the training data files
    subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
    xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
    yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
    ##3. Uses descriptive activity names to name the activities in the data set
    names(subjectTrain) <- c("subjectId")
    names(xTrain) <- features$featureName
    names(yTrain) <- c("activityId")
    
    #checking training data consistency and merge data
    if(nrow(subjectTrain) !=  nrow(xTrain) && nrow(yTrain) !=  nrow(xTrain)){
        print("Data Length Not same")
    }
    trainingData <- cbind(subjectTrain,yTrain,xTrain) 
    
    ##read the test data files
    subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
    xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
    ##3. Uses descriptive activity names to name the activities in the data set
    names(subjectTest) <- c("subjectId")
    names(xTest) <- features$featureName
    names(yTest) <- c("activityId")
    
    #checking test data consistency and merge data
    if(nrow(subjectTest) !=  nrow(xTest) && nrow(yTest) !=  nrow(xTest)){
        print("Data Length Not same")
    }
    testingData <- cbind(subjectTest,yTest,xTest) 
    
    ##1. Merges the training and the test sets to create one data set.
    totalData <- rbind(trainingData,testingData)

    ##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    featuresWanted <- intersect(grep("mean|std",features$featureName), grep("Freq",features$featureName,invert=TRUE))
    ##add two columns for subject and activity to create final columns wanted
    columnsWantedWanted <- c(1,2,featuresWanted+2)
    
    finalData <- totalData[,columnsWantedWanted]
    
    ##4. Appropriately labels the data set with descriptive variable names. 
    columnNames <-  names(finalData)
    columnNames <- gsub("\\()", "", columnNames)
    columnNames <- gsub("mean()", "Mean", columnNames)
    columnNames <- gsub("std()", "StdDev", columnNames)
    names(finalData) <- columnNames
    finalData <- merge(finalData,activities,by='activityId',all.x=TRUE)

    ##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    tidyData <- aggregate(finalData,by = list(activityDes = finalData$activityName,activityId1 = finalData$activityId,subjectId1 = finalData$subjectId),mean)
    dropsCol <- c("activityName","activityId1","subjectId1")
    tidyData <- tidyData[,!(names(tidyData) %in% dropsCol)]
    write.table(tidyData,file = "tidy_data.txt",row.names = FALSE)
}