# INITIAL FILE DEFINITIONS AS GIVEN BY README.TXT
# 'features_info.txt': Shows information about the variables used on the feature vector.
# 'features.txt': List of all features.
#  'activity_labels.txt': Links the class labels with their activity name.
# 'train/X_train.txt': Training set.
#  'train/y_train.txt': Training labels.
#  'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.
# we have 2 datasets for each set: sets and labels. 
# we have a list of variable names: features
# run_analysis.R 
#step 1 - merge datasets
#these are the paths I unzipped files to:
ActTr<-read.table("./Documents/UCI HAR Dataset/train/y_train.txt",header=FALSE)
ActTs<-read.table("./Documents/UCI HAR Dataset/test/y_test.txt",header=FALSE)
SubTr<-read.table("./Documents/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
SubTs<-read.table("./Documents/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
FeatTr<-read.table("./Documents/UCI HAR Dataset/train/X_train.txt",header=FALSE)
FeatTs<-read.table("./Documents/UCI HAR Dataset/test/X_test.txt",header=FALSE)
Act<-rbind(ActTr,ActTs)
Sub<-rbind(SubTr,SubTs)
Feat<-rbind(FeatTr,FeatTs)
#we arrange ad hoc names to merge
colnames(Sub)<-"Sub"
colnames(Act)<-"Act"
FeatArray<-read.table("./Documents/UCI HAR Dataset/features.txt",header=FALSE)
FeatArray<-FeatArray$V2
colnames(Feat)<-FeatArray
#merge
DF1<-cbind(Feat,cbind(Sub,Act))
DF1<-as.data.frame(DF1)
#step 2
#Extracts only the measurements on the mean and standard deviation for each measurement.
#but keep subject and activity!
DF2<-cbind(DF1[ , grepl( "-mean()" , names( DF1) ) ],DF1[ , grepl( "std()" , names( DF1) ) ],DF1[ , ((ncol(DF1)-1):ncol(DF1))])
#step 3
#Uses descriptive activity names to name the activities in the data set
ActNames<-read.table("./Documents/UCI HAR Dataset/activity_labels.txt",header=FALSE)
#join these to the dataset in a new variable Act_Names
library(plyr)
library(dplyr)
ActNames<-rename(ActNames,Act_Names=V2, Act=V1)
DF2<-left_join(DF2,ActNames)