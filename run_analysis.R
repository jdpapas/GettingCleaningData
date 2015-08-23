## Description
## run_analysis: Makes data from the "Human Activity Recognition Using Smartphones Data Set" tidy 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

run_analysis <- function() 
{
    # 1.Merges the training and the test sets to create one data set.
        setwd(paste(Sys.getenv("USERPROFILE"), "\\Documents\\GitHub\\ProgrammingAssignment_cleandata\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset", sep=""))
        measurements <- read.csv("features.txt", header=F, stringsAsFactors = F, sep=" ")
        measurement_cols <- measurements$V2   # only grab the second column - it contains all the column names for our measurements
        activities <- read.csv("activity_labels.txt", header=F, stringsAsFactors = F, sep=" ")

        #read in the x, y, and subject data sets for train and test
        x_train <- read.csv("train\\x_train.txt", stringsAsFactors = F, header=F, sep="", numerals ="no.loss")
        x_test <- read.csv("test\\x_test.txt", stringsAsFactors = F, header=F, sep="", numerals ="no.loss")
        y_train <- read.csv("train\\y_train.txt", stringsAsFactors = F, header=F, sep="")
        y_test <- read.csv("test\\y_test.txt", stringsAsFactors = F, header=F, sep="")
        subject_train <- read.csv("train\\subject_train.txt", stringsAsFactors = F, header=F)
        subject_test <- read.csv("test\\subject_test.txt", stringsAsFactors = F, header=F)

        # combine the train and test data sets for x, y, and subject
        x_merged <- rbind(x_train, x_test)
        y_merged <- rbind(y_train, y_test)
        subject_merged <- rbind(subject_train, subject_test)

    # 4. Appropriately labels the data set with descriptive variable names. 
        names(x_merged) <- measurement_cols
        names(y_merged) <- "activity"
        names(subject_merged) <- "subject"
        names(activities) <- c("id", "names")
        
        # combine subject, activity, and measurements into one dataset
        fulldata <- cbind(subject_merged, y_merged, x_merged)

    # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        col_names <- names(fulldata)
        #indices of the columns which have the word "mean" or "std" in them (does not include vectors with "Mean" in the name used in angle() variable - see features_info.txt)
        mean_std_cols <- grep("mean|std", col_names, value = F)
        # keep cols 1 (subject) and 2 (activity), and the mean/std columns only
        mean_std_data = fulldata[c(1, 2, mean_std_cols)]
        
    # 3. Uses descriptive activity names to name the activities in the data set
        mean_std_data$activity <- activities$name[mean_std_data$activity]

    # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        # This thread on SO was helpful in figuring this out: http://stackoverflow.com/questions/21295936/can-dplyr-summarise-over-several-variables-without-listing-each-one/24455439#24455439
        tidy_data <- mean_std_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

        # write out the tidy data set
        write.table(tidy_data, "tidy.txt", row.names = FALSE)
}

