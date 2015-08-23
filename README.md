# GettingCleaningData
Getting and Cleaning Data - https://www.coursera.org/course/getdata
Course Project - https://class.coursera.org/getdata-031/human_grading/view/courses/975115/assessments/3/submissions

Description
run_analysis: Makes data from the ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "link") tidy 

Data is located in the getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset directory
The run_analysis.R function does the following:
1. Iterates through the data files on subjects, activities, and measurements
2. merges the training and test data, for subjects, activities, and meausurements into one data set
3. Labels the data set with descriptive column names
4. Extracts out all measurements related to mean or standard deviation, and removes other columns
5. Uses descriptive activity names to name the activities in the data set
6. Creates a tidy data set contianing the average of each measurement for each combination of subject/activity

Note: You will need to change the working directory referenced in the run_analsis.R to point to the location of the data files.
