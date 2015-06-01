#Getting And Cleaning Data Assignment

Creating a tidy data set of wearable computing data originally taken from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##List of files in this repository are:-

1. Readme.md
2. Tidy.txt
3. run_analysis.R
4. Code Book.txt

##Explaination of run_analysis.R

This R file performs the cleaning operation on the original data set taken from the aforementioned website.
The list of operations performed by this file includes:-
* Merges the training and the test sets to create one data set.(used rbind() to perform this action.)
* Extracts only the measurements on the mean and standard deviation for each measurement.(referred features.txt and used grepl to extract columns having mean and Standard deviation values.)
* Uses descriptive activity names to name the activities in the data set.(referred to activity_labels.txt and used if else conditions to convert the numeric values to names)
* Appropriately labels the data set with descriptive variable names.(referred to features.txt to extract only the mean and std columns.) 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.(used aggregate function and decomposed table based on Subject and Activity and ordered them by Subject and Activity.)

The output of the R code is stored in a text file named as Tidy.txt containing 181 rows with 88 columns.

##Description of Tidy.txt

Tidy.txt is the text file created by performing cleaning operations on the original dataset obtained from the website. It depicts the average of each variable
for each activity and each subject, the first row being the names of the variables.
There are 181 rows with 88 dimensions. 1st and the 2nd columns refering to the Subject and the Activity. The rest of the 86 dimensions are the measurement
variables with respect to the mean and Standard Deviation of the different calculations.



