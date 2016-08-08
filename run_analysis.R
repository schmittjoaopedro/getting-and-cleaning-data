#Colocar library(dplyr)
#Colocar merge_data_sets na chamada principal

run_analysis <- function() {
    
    #merge_data_sets();
    
	# Defines all data directories
	baseDir <- "./data/"
	outputDir <- paste(baseDir, "output/", sep = "")
    
    if(!file.exists(outputDir)) dir.create(outputDir)

    # Reads the activities labels
    activities <- read.table(paste(baseDir, "activity_labels.txt", sep = ""), col.names = c("id","activity"))
    sensorlabels <- read.table(paste(baseDir, "features.txt", sep = ""), col.names = c("id","features"))
    
    rawX <- read.table(paste(outputDir, "X_raw.txt", sep = ""), col.names = sensorlabels$features)
    rawSubject <- read.table(paste(outputDir, "subject_raw.txt", sep = ""), col.names = "subject")
    rawY <- read.table(paste(outputDir, "y_raw.txt", sep = ""), col.names = "activityid")
    rawY <- rawY %>% mutate(activitylabel = activities[activityid,]$activity)
    rawY <- cbind(rawY, rawSubject, rawX)
    rawX <- rawY[,2:dim(rawY)[2]]
    rawX <- rawX[,grepl("activitylabel|subject|-mean()|-std()", names(rawX))]
    names(rawX) <- gsub("\\.","", tolower(names(rawX)))
    write.csv(rawX, file = paste(outputDir, "tidy_data.csv", sep = ""), col.names = T, row.names = F)
    
}

merge_data_sets <- function () {
    
    baseDir <- "./data/"
    trainDir <- paste(baseDir, "train/", sep = "")
    testDir <- paste(baseDir, "test/", sep = "")
    outputDir <- paste(baseDir, "output/", sep = "")
    
    if(!file.exists(outputDir)) dir.create(outputDir)
    
    trainX <- read.table(paste(trainDir, "X_train.txt", sep = ""), colClasses = "character")
    testX <- read.table(paste(testDir, "X_test.txt", sep = ""), colClasses = "character")
    write.table(rbind(trainX, testX), file = "./data/output/X_raw.txt", col.names = F, row.names = F, quote = F)
    
    trainY <- read.table(paste(trainDir, "y_train.txt", sep = ""), colClasses = "character")
    testY <- read.table(paste(testDir, "y_test.txt", sep = ""), colClasses = "character")
    write.table(rbind(trainY, testY), file = "./data/output/y_raw.txt", col.names = F, row.names = F, quote = F)
    
    trainSubject <- read.table(paste(trainDir, "subject_train.txt", sep = ""), colClasses = "character")
    testSubject <- read.table(paste(testDir, "subject_test.txt", sep = ""), colClasses = "character")
    write.table(rbind(trainSubject, testSubject), file = "./data/output/subject_raw.txt", col.names = F, row.names = F, quote = F)
}









