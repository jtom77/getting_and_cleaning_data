library(plyr)

## collect the test and train data
xtest <- read.table("./UCI HAR Dataset-2/test/X_test.txt", header=FALSE)
xtrain <- read.table("./UCI HAR Dataset-2/train/X_train.txt", header=FALSE)
x <- rbind(xtest, xtrain)

## collect the activity vector
ytest <- read.table("./UCI HAR Dataset-2/test/y_test.txt", header=FALSE, colClasses=c("factor"))
ytrain <- read.table("./UCI HAR Dataset-2/train/y_train.txt", header=FALSE, colClasses=c("factor"))
y <- rbind(ytest, ytrain)

## rename the activity levels
y[,1] <- revalue(y[,1],c('1'='WALKING','2'='WALKING_UPSTAIRS','3'='WALKING_DOWNSTAIRS','4'='SITTING','5'='STANDING','6'='LAYING'))

## get the column names from feature.txt and rename the columns
features <- read.table("./UCI HAR Dataset-2/features.txt", header=FALSE)
colnames(x) <- features[,2]
colnames(y) <- c("Activity")

## add the activity column to the data set
x <- cbind(y, x)

## subset the data frame to columns containing "mean" or "std" in their name 
meanStdCols <- c(1,1+grep(pattern="(mean|std)",as.character(features[,2])))
x <- x[,meanStdCols]

## the tidy data set of step 5
result <- aggregate(x[, 2:80], list(x$Activity), mean)

print(result)

