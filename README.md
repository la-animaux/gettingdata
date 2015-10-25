Getting and Cleaning Data Class - Course Project

This is a readme file that describes the course project for the Getting and Cleaning Data course project. 

There are three parts of this submission:
(1) This readme file
(2) A tidy dataset, called "FinalData" or "data.txt"
(3) A codebook

The code completes the course project for Getting and Cleaning Data
It does five steps:

    1. Merges the training and the test sets to create one data set.
    
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    
    3. Uses descriptive activity names to name the activities in the data set
    
    4. Appropriately labels the data set with descriptive variable names. 
    
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and  each subject.

The end result is a tidy dataset named FinalData. 

<b>How were the variables selected for the final tidy dataset? </b>
Included variables were selected if the variable named contained "mean" or "std-dev". Variables with "meanFreq" in the name were NOT included. 

<b>What type of variables are these?</b>
The SubjectNumber and ActivityType variables are categorical and reference the subject number and type of activity performed, respectively. All other variables are numeric means. 

<b>What was the original dataset?</b>
The original, raw dataset was compiled by the UCI Machine Learning Repository. More information about these data can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
