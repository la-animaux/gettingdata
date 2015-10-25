##This code completes the course project for Getting and Cleaning Data
##It does five steps:
    ## 1. Merges the training and the test sets to create one data set.
    ## 2. Extracts only the measurements on the mean and standard deviation 
    ##    for each measurement. 
    ## 3. Uses descriptive activity names to name the activities in the data set
    ## 4. Appropriately labels the data set with descriptive variable names. 
    ## 5. From the data set in step 4, creates a second, independent tidy 
    ##    data set with the average of each variable for each activity and 
    ##    each subject.

##Check that the Samsung data is in the working directory
if (!file.exists("X_train.txt")) { print(message("The training data is not present")) }
if (!file.exists("X_test.txt")) { print(message("The test data is not present")) }

##Load necessary package
library(data.table)
library(plyr)
library(httr)

# STEP ONE: MERGE DATA

##Load the data
colLabels <- readLines("features.txt")
XTrain <- read.table("X_train.txt")
colnames(XTrain) <- colLabels
YTrain <- read.table("y_train.txt")
colnames(YTrain) <- "TrainingLabels"
SubTrain <- read.table("subject_train.txt")
colnames(SubTrain) <- "SubjectNumber"
TrainData <- cbind(SubTrain, YTrain, XTrain)
TrainData$Sample <- "Training"
print("The training data is loaded")

XTest <- read.table("X_test.txt")
colnames(XTest) <- colLabels
YTest <- read.table("y_test.txt")
colnames(YTest) <- "TrainingLabels"
SubTest <- read.table("subject_test.txt")
colnames(SubTest) <- "SubjectNumber"
TestData <- cbind(SubTest, YTest, XTest)
TestData$Sample <- "Testing"
print("The test data is loaded")

rm(XTrain, YTrain, SubTrain, XTest, YTest, SubTest, colLabels)  #removes unnecessary data from memory

AllData <- rbind(TestData, TrainData)

rm(TestData,TrainData)

# STEP TWO: EXTRACT SUMMARY DATA
TidyData <- subset.data.frame(AllData, select = c("SubjectNumber", "TrainingLabels", 
                                                    "1 tBodyAcc-mean()-X", "2 tBodyAcc-mean()-Y", 
                                                    "3 tBodyAcc-mean()-Z", "4 tBodyAcc-std()-X", 
                                                    "5 tBodyAcc-std()-Y", "6 tBodyAcc-std()-Z", 
                                                    "41 tGravityAcc-mean()-X", 
                                                    "42 tGravityAcc-mean()-Y", "43 tGravityAcc-mean()-Z", 
                                                    "44 tGravityAcc-std()-X", "45 tGravityAcc-std()-Y", 
                                                    "46 tGravityAcc-std()-Z", 
                                                    "81 tBodyAccJerk-mean()-X", "82 tBodyAccJerk-mean()-Y",
                                                    "83 tBodyAccJerk-mean()-Z", "84 tBodyAccJerk-std()-X", 
                                                    "85 tBodyAccJerk-std()-Y", "86 tBodyAccJerk-std()-Z", 
                                                    "121 tBodyGyro-mean()-X", 
                                                    "122 tBodyGyro-mean()-Y", "123 tBodyGyro-mean()-Z", 
                                                    "124 tBodyGyro-std()-X", "125 tBodyGyro-std()-Y", 
                                                    "126 tBodyGyro-std()-Z", 
                                                    "161 tBodyGyroJerk-mean()-X", "162 tBodyGyroJerk-mean()-Y", 
                                                    "163 tBodyGyroJerk-mean()-Z", 
                                                    "164 tBodyGyroJerk-std()-X", "165 tBodyGyroJerk-std()-Y",
                                                    "166 tBodyGyroJerk-std()-Z",
                                                    "201 tBodyAccMag-mean()", "202 tBodyAccMag-std()",
                                                    "214 tGravityAccMag-mean()", "215 tGravityAccMag-std()",
                                                    "227 tBodyAccJerkMag-mean()", "228 tBodyAccJerkMag-std()",
                                                    "240 tBodyGyroMag-mean()", "241 tBodyGyroMag-std()",
                                                    "253 tBodyGyroJerkMag-mean()", "254 tBodyGyroJerkMag-std()",
                                                    "266 fBodyAcc-mean()-X", "267 fBodyAcc-mean()-Y", 
                                                    "268 fBodyAcc-mean()-Z", "269 fBodyAcc-std()-X", 
                                                    "270 fBodyAcc-std()-Y", "271 fBodyAcc-std()-Z", 
                                                    "345 fBodyAccJerk-mean()-X", "346 fBodyAccJerk-mean()-Y", 
                                                    "347 fBodyAccJerk-mean()-Z", "348 fBodyAccJerk-std()-X",
                                                    "349 fBodyAccJerk-std()-Y", "350 fBodyAccJerk-std()-Z",
                                                    "424 fBodyGyro-mean()-X", 
                                                    "425 fBodyGyro-mean()-Y", "426 fBodyGyro-mean()-Z", 
                                                    "427 fBodyGyro-std()-X", "428 fBodyGyro-std()-Y", 
                                                    "429 fBodyGyro-std()-Z",
                                                    "503 fBodyAccMag-mean()", "504 fBodyAccMag-std()",   
                                                    "516 fBodyBodyAccJerkMag-mean()", "517 fBodyBodyAccJerkMag-std()",
                                                    "529 fBodyBodyGyroMag-mean()", "530 fBodyBodyGyroMag-std()",
                                                    "542 fBodyBodyGyroJerkMag-mean()", "543 fBodyBodyGyroJerkMag-std()",
                                                    "555 angle(tBodyAccMean,gravity)", 
                                                    "556 angle(tBodyAccJerkMean),gravityMean)", 
                                                    "557 angle(tBodyGyroMean,gravityMean)", 
                                                    "558 angle(tBodyGyroJerkMean,gravityMean)", 
                                                    "559 angle(X,gravityMean)", "560 angle(Y,gravityMean)", 
                                                    "561 angle(Z,gravityMean)", "Sample"))

rm(AllData)  #remove old files from memory

##STEP THREE: USE DESCRIPTIVE ACTIVITY NAMES
TidyData$TrainingLabels[TidyData$TrainingLabels==1] <- "Walking"
TidyData$TrainingLabels[TidyData$TrainingLabels==2] <- "Walking_Upstairs"
TidyData$TrainingLabels[TidyData$TrainingLabels==3] <- "Walking_Downstairs"
TidyData$TrainingLabels[TidyData$TrainingLabels==4] <- "Sitting"
TidyData$TrainingLabels[TidyData$TrainingLabels==5] <- "Standing"
TidyData$TrainingLabels[TidyData$TrainingLabels==6] <- "Laying"



##STEP FOUR: USE DESCRIPTIVE VARIABLE NAMES

setnames(TidyData, "TrainingLabels", "ActivityType")
setnames(TidyData, "1 tBodyAcc-mean()-X", "1 Body Acceleration Mean X")
setnames(TidyData, "2 tBodyAcc-mean()-Y", "2 Body Acceleration Mean Y")
setnames(TidyData, "3 tBodyAcc-mean()-Z", "3 Body Acceleration Mean Z")
setnames(TidyData, "4 tBodyAcc-std()-X", "4 Body Acceleration Standard Deviation X")
setnames(TidyData, "5 tBodyAcc-std()-Y",  "5 Body Acceleration Standard Deviation Y")
setnames(TidyData, "6 tBodyAcc-std()-Z", "6 Body Acceleration Standard Deviation Z")
setnames(TidyData, "41 tGravityAcc-mean()-X", "41 Gravity Acceleration Mean X")
setnames(TidyData, "42 tGravityAcc-mean()-Y", "42 Gravity Acceleration Mean Y")
setnames(TidyData, "43 tGravityAcc-mean()-Z", "43 Gravity Acceleration Mean Z")
setnames(TidyData, "44 tGravityAcc-std()-X", "44 Gravity Acceleration Standard Deviation X")
setnames(TidyData, "45 tGravityAcc-std()-Y", "45 Gravity Acceleration Standard Deviation Y")
setnames(TidyData, "46 tGravityAcc-std()-Z", "46 Gravity Acceleration Standard Deviation Z")
setnames(TidyData, "81 tBodyAccJerk-mean()-X", "81 Body Linear Acceleration Mean X")
setnames(TidyData, "82 tBodyAccJerk-mean()-Y", "82 Body Linear Acceleration Mean Y")
setnames(TidyData, "83 tBodyAccJerk-mean()-Z", "83 Body Linear Acceleration Mean Z")
setnames(TidyData, "84 tBodyAccJerk-std()-X", "84 Body Linear Acceleration Standard Deviation X")
setnames(TidyData, "85 tBodyAccJerk-std()-Y", "85 Body Linear Acceleration Standard Deviation Y")
setnames(TidyData, "86 tBodyAccJerk-std()-Z", "86 Body Linear Acceleration Standard Deviation Z")
setnames(TidyData, "121 tBodyGyro-mean()-X", "121 Body Gyroscope Mean X")
setnames(TidyData, "122 tBodyGyro-mean()-Y",  "122 Body Gyroscope Mean Y")
setnames(TidyData, "123 tBodyGyro-mean()-Z", "123 Body Gyroscope Mean Z")
setnames(TidyData, "124 tBodyGyro-std()-X", "124 Body Gyroscope Standard Deviation X")
setnames(TidyData, "125 tBodyGyro-std()-Y", "125 Body Gyroscope Standard Deviation Y")
setnames(TidyData, "126 tBodyGyro-std()-Z", "126 Body Gyroscope Standard Deviation Z")
setnames(TidyData, "161 tBodyGyroJerk-mean()-X", "161 Angular velocity Mean X")
setnames(TidyData, "162 tBodyGyroJerk-mean()-Y", "162 Angular velocity Mean Y")
setnames(TidyData, "163 tBodyGyroJerk-mean()-Z", "163 Angular velocity Mean Z")
setnames(TidyData, "164 tBodyGyroJerk-std()-X", "164 Angular velocity Standard Deviation X")
setnames(TidyData, "165 tBodyGyroJerk-std()-Y", "165 Angular velocity Standard Deviation Y")
setnames(TidyData, "166 tBodyGyroJerk-std()-Z", "166 Angular velocity Standard Deviation Z")
setnames(TidyData, "201 tBodyAccMag-mean()", "201 Body Acceleration Magnitude Mean")
setnames(TidyData, "202 tBodyAccMag-std()", "202 Body Acceleration Magnitude Standard Deviation")
setnames(TidyData, "214 tGravityAccMag-mean()", "214 Gravity Acceleration Magnitude Mean")
setnames(TidyData, "215 tGravityAccMag-std()", "215 Gravity Acceleration Magnitude Standard Deviation")
setnames(TidyData, "227 tBodyAccJerkMag-mean()", "227 Body Linear Acceleration Magnitude Mean")
setnames(TidyData, "228 tBodyAccJerkMag-std()", "228 Body Linear Acceleration MagnitudeS tandard Deviation")
setnames(TidyData, "240 tBodyGyroMag-mean()", "240 Body Gyroscope Magnitude Mean")
setnames(TidyData, "241 tBodyGyroMag-std()", "241 Body Gyroscope Magnitude Standard Deviation")
setnames(TidyData, "253 tBodyGyroJerkMag-mean()", "253 Angular velocity Magnitude Mean")
setnames(TidyData, "254 tBodyGyroJerkMag-std()", "254 Angular velocity Magnitude Standard Deviation")
setnames(TidyData, "266 fBodyAcc-mean()-X", "266 FFT Body Acceleration Mean X")
setnames(TidyData, "267 fBodyAcc-mean()-Y", "267 FFT Body Acceleration Mean Y")
setnames(TidyData, "268 fBodyAcc-mean()-Z", "268 FFT Body Acceleration Mean Z")
setnames(TidyData, "269 fBodyAcc-std()-X", "269 FFT Body Acceleration Standard Deviation X")
setnames(TidyData, "270 fBodyAcc-std()-Y", "270 FFT Body Acceleration Standard Deviation Y")
setnames(TidyData, "271 fBodyAcc-std()-Z", "271 FFT Body Acceleration Standard Deviation Z")
setnames(TidyData, "345 fBodyAccJerk-mean()-X", "345 FFT Body Linear Acceleration Mean Z")
setnames(TidyData, "346 fBodyAccJerk-mean()-Y", "346 FFT Body Linear Acceleration Mean Y")
setnames(TidyData, "347 fBodyAccJerk-mean()-Z", "347 FFT Body Linear Acceleration Mean Z")
setnames(TidyData, "348 fBodyAccJerk-std()-X", "348 FFT Body Linear Acceleration Standard Deviation X")
setnames(TidyData, "349 fBodyAccJerk-std()-Y", "349 FFT Body Linear Acceleration Standard Deviation Y")
setnames(TidyData, "350 fBodyAccJerk-std()-Z", "350 FFT Body Linear Acceleration Standard Deviation Z")
setnames(TidyData, "424 fBodyGyro-mean()-X", "424 FFT Body Gyroscope Mean X")
setnames(TidyData, "425 fBodyGyro-mean()-Y", "425 FFT Body Gyroscope Mean Y")
setnames(TidyData, "426 fBodyGyro-mean()-Z", "426 FFT Body Gyroscope Mean Z")
setnames(TidyData, "427 fBodyGyro-std()-X", "427 FFT Body Gyroscope Standard Deviation X")
setnames(TidyData, "428 fBodyGyro-std()-Y", "428 FFT Body Gyroscope Standard Deviation Y")
setnames(TidyData, "429 fBodyGyro-std()-Z", "429 FFT Body Gyroscope Standard Deviation Z")
setnames(TidyData, "503 fBodyAccMag-mean()", "503 FFT Body Linear Acceleration Magnitude Mean")
setnames(TidyData, "504 fBodyAccMag-std()", "504 FFT Body Linear Acceleration Magnitude Standard Deviation")
setnames(TidyData, "516 fBodyBodyAccJerkMag-mean()", "516 FFT Body Linear Acceleration Magnitude Mean")
setnames(TidyData, "517 fBodyBodyAccJerkMag-std()", "517 FFT Body Linear Acceleration Magnitude Standard Deviation")
setnames(TidyData, "529 fBodyBodyGyroMag-mean()", "529 FFT Body Gyroscope Magnitude Mean")
setnames(TidyData, "530 fBodyBodyGyroMag-std()", "530 FFT Body Gyroscope Magnitude Standard Deviation")
setnames(TidyData, "542 fBodyBodyGyroJerkMag-mean()", "542 Angular velocity Magnitude Mean")
setnames(TidyData, "543 fBodyBodyGyroJerkMag-std()", "542 Angular velocity Magnitude Standard Deviation")
setnames(TidyData, "555 angle(tBodyAccMean,gravity)", "555 Average Body Acceleration and Gravity")
setnames(TidyData, "556 angle(tBodyAccJerkMean),gravityMean)", "556 Average Linear Acceleration and Gravity")
setnames(TidyData, "557 angle(tBodyGyroMean,gravityMean)", "557 Average Body Gyroscope and Gravity")
setnames(TidyData, "558 angle(tBodyGyroJerkMean,gravityMean)", "558 Average Angular Velocity and Gravity")
setnames(TidyData, "559 angle(X,gravityMean)", "559 Average Gravity for X Variables")
setnames(TidyData, "560 angle(Y,gravityMean)", "560 Average Gravity for Y Variables")
setnames(TidyData, "561 angle(Z,gravityMean)", "561 Average Gravity for Z Variables")



##STEP FIVE: CREATE A DATASET WITH AVERAGES FOR EACH SUBJECT AND ACTIVITY PAIR

#Extract unique combination of Subjects and Activities
FinalData <- aggregate(TidyData[, 3:75], list(TidyData$SubjectNumber, TidyData$ActivityType), mean)
rm(TidyData)
