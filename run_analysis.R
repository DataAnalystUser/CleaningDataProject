
testDataX <- read.table("X_test.txt",header=FALSE)        #Load all data sets into R
trainDataX <- read.table("X_train.txt",header=FALSE)
testActivitiesy <- read.table("y_test.txt",header=FALSE)
trainActivitiesy <- read.table("y_train.txt",header=FALSE)
testSubjects <- read.table("subject_test.txt",header=FALSE)
trainSubjects <- read.table("subject_train.txt",header=FALSE)
activityLabels <- read.table("activity_labels.txt",header=FALSE,colClasses="character")

testActivitiesy$V1 <- factor(testActivitiesy$V1,levels=activityLabels$V1,labels=activityLabels$V2) #Merge activity
trainActivitiesy$V1 <- factor(trainActivitiesy$V1,levels=activityLabels$V1,labels=activityLabels$V2)

features <- read.table("features.txt",header=FALSE,colClasses="character")[,2] #Load the features

names(testDataX)<-features             #Load headings to data
names(trainDataX)<-features

newfeatures <- grepl("mean|std", features)   #Subset data
testDataX <- testDataX[,newfeatures]         
trainDataX <-trainDataX[,newfeatures] 

colnames(testActivitiesy)<-c("Activity")    #Name columns
colnames(trainActivitiesy)<-c("Activity")
colnames(testSubjects)<-c("Subject")
colnames(trainSubjects)<-c("Subject")
CompleteTest<-cbind(testDataX,testActivitiesy)  #Combine all data
CompleteTest<-cbind(CompleteTest,testSubjects)
CompleteTrain<-cbind(trainDataX,trainActivitiesy)
CompleteTrain<-cbind(CompleteTrain,trainSubjects)
completeFrame<-rbind(CompleteTest,CompleteTrain)

final<-aggregate(. ~ Activity + Subject,completeFrame,mean) #Aggregate data by required columns

write.table(final, file = "./tidydata.txt", row.name = FALSE)  #Write script

