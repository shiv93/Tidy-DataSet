run_analysis<-function(){
trainingSet<-read.table("D:/R/UCI HAR Dataset/train/X_train.txt")
activityTrain<-read.table("D:/R/UCI HAR Dataset/train/y_train.txt")
subjTrain<-read.table("D:/R/UCI HAR Dataset/train/subject_train.txt")

testSet<-read.table("D:/R/UCI HAR Dataset/test/X_test.txt")
subjTest<-read.table("D:/R/UCI HAR Dataset/test/subject_test.txt")
activityTest<-read.table("D:/R/UCI HAR Dataset/test/y_test.txt")

mergedSet <- rbind(trainingSet,testSet)

mergeTrain<-cbind(subjTrain,activityTrain)
mergeTest<-cbind(subjTest,activityTest)

totalMerge<- rbind(mergeTrain,mergeTest)
names(totalMerge)<-c("Subject","Activity")

mergedSet<-cbind(totalMerge,mergedSet)

onlyMeasurements<-mergedSet[,3:563]
features<-read.table("D:/R/UCI HAR Dataset/features.txt")
forMeanColumns<-grepl("mean",features$V2,ignore.case=TRUE)
forStdColumns<-grepl("std",features$V2,ignore.case=TRUE)
measurementsOnMeanAndStd<-onlyMeasurements[,forMeanColumns | forStdColumns]
colIndex<-which(forMeanColumns | forStdColumns)

features<-read.table("D:/R/UCI HAR Dataset/features.txt")  
namesOfFeatures<-features$V2
namesOfFeatures<-namesOfFeatures[colIndex]
names(measurementsOnMeanAndStd)<-namesOfFeatures

names(measurementsOnMeanAndStd)<-gsub("Acc", "Accelerometer", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("Gyro", "Gyroscope", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("BodyBody", "Body", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("Mag", "Magnitude", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("^t", "Time", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("^f", "Frequency", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("tBody", "TimeBody", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("-mean()", "Mean", names(measurementsOnMeanAndStd), ignore.case = TRUE)
names(measurementsOnMeanAndStd)<-gsub("-std()", "STD", names(measurementsOnMeanAndStd), ignore.case = TRUE)
names(measurementsOnMeanAndStd)<-gsub("-freq()", "Frequency", names(measurementsOnMeanAndStd), ignore.case = TRUE)
names(measurementsOnMeanAndStd)<-gsub("angle", "Angle", names(measurementsOnMeanAndStd))
names(measurementsOnMeanAndStd)<-gsub("gravity", "Gravity", names(measurementsOnMeanAndStd))

mergedSet<-cbind(totalMerge,measurementsOnMeanAndStd)
count<-1
for(i in mergedSet$Activity){
  if(i==1)
    mergedSet$Activity[count]="Walking"
  else if(i==2)
    mergedSet$Activity[count]="Walking Upstairs"
  else if(i==3)
    mergedSet$Activity[count]="Walking Downstairs"
  else if(i==4)
    mergedSet$Activity[count]="Sitting"
  else if(i==5)
    mergedSet$Activity[count]="Standing"
  else
    mergedSet$Activity[count]="Laying"
  count<-count+1
}
mergedSet$Subject<-as.factor(mergedSet$Subject)
tidySet<-aggregate(. ~Subject+Activity,mergedSet,mean)
tidySet <- tidySet[order(tidySet$Subject,tidySet$Activity),]
write.table(tidySet,file="D:/R/Tidy.txt",row.names=FALSE)
}