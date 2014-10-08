library(data.table)

## Read and merge all training datasets with testing datasets  
# read and merge experiment data testing and traning datasets
data <- rbind(read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE), read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE))

# read and merge activity testing and training datasets
data.activity <- rbind(read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE), read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE))

# read and merge subject testing and training datasets
data.subject <- rbind(read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE), read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE))


## 4. Appropriately labels the data set with descriptive variable names
# read features list to be used for labeling
features <- read.table("UCI HAR Dataset/features.txt")
  
# label all merged datasets 
colnames(data) <- features[,2]
colnames(data.activity) <- "Activity"
colnames(data.subject) <- "Subject"


## 1. Merges the training and the test sets to create one data set
data.all <- cbind(data.subject, data.activity, data )


## 3. Uses descriptive activity names to name the activities in the data set
# read activities list and set up labels for merging. activities sorted by ID
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# extract activities description as factor
activities <- activities[,2]

# replace activity ID with activity label 
data.all[,"Activity"] = activities[data.all[,"Activity"]]


## 2. Extracts only the measurements on the mean and standard deviation for each measurement
# mean and standard deviation labels contain "mean()" and "std()". search for these labels in features  
means_n_std <- grepl("Activity|Subject|mean\\(\\)|std\\(\\)", colnames(data.all))

data.means_n_std <- data.all[, means_n_std]


## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

data.tidy <- aggregate(. ~ Subject + Activity, data=data.means_n_std, FUN = mean)
write.table(data.tidy,file="tidyData.txt",sep=",",row.names = FALSE)


