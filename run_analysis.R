library(dplyr)
options(stringsAsFactors = FALSE) # drop levels

# Read data from source

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt",sep="\n") # read in as one single column
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names = features$V1,
                     check.names = FALSE) # prevent R from converting "()" to ".."
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "Activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",col.names = features$V1,
                      check.names = FALSE) # prevent R from converting "()" to ".."
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "Activity")

# Merge, arrange and extract

test <- cbind(subject_test,y_test,X_test)
train <- cbind(subject_train,y_train,X_train)
data <- arrange(rbind(test,train),Subject,Activity) # merge training and test sets
ind_mean_std <- grep("mean\\(\\)|std\\(\\)",colnames(data)) # "\\" enables parenthesis recognition
data_mean_std <- data[,c(1,2,ind_mean_std)] # extract mean and standard variation data

# Rename activity labels

for (i in 1:nrow(data_mean_std)) {
    for (j in 1:nrow(activity_labels)) {
        if (data_mean_std$Activity[i]==j) {
            data_mean_std$Activity[i] <- activity_labels[j,2]
        }
    }
}

# Rename variables

colnames(data_mean_std) <- gsub(".* "," ",colnames(data_mean_std))
    # "." = any single character, "*" = repeats preceding item any times, 
    # so ".*" = any number of any character

colnames(data_mean_std) <- gsub(" t","time",colnames(data_mean_std))
colnames(data_mean_std) <- gsub(" f","frequency",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("Acc","LinearAcceleration",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("Gyro","AngularVelocity",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("Mag","Magnitude",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("std","standard-deviation",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("\\(\\)","",colnames(data_mean_std))
colnames(data_mean_std) <- gsub("BodyBody","Body",colnames(data_mean_std))

# Create tidy data set with average of each variable for each activity and subject

group <- group_by(data_mean_std,Subject,Activity)
avgsummary <- summarize_each(group,funs(mean)) # average each column by group
write.table(avgsummary,file = "avgsummary.txt",row.names = FALSE) # output tidy data set
