# requires the use of the SQLDF and Plyr packages

require(plyr)
require(sqldf)

#  The only assumption here is that you have created a directory called C:\R\ and it is currently empty

setwd("C:/R/")

#  Download the activity dataset and put into the R directory as a zip file

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","C:/R/Dataset.zip")

#Unzip the data file

unzip("Dataset.zip")

# This will create a new directory called UCI HAR Dataset
# Change the working directory to point to the main activity files

setwd("C:/R/UCI HAR Dataset/")

# Load in the main activity files 
# These do not contain any observations; only references which we will use later

main.lbl <-  read.table("activity_labels.txt",header=FALSE,sep ="")
main.feat <-  read.table("features.txt",header=FALSE,sep ="")

# There are two sets of observations:  test and train
# We will change the working directory to test to load the test observations first

setwd("C:/R/UCI HAR Dataset/test/")

# Load the test subject # 
# This is a dataset which represents the person who made the observation

test.subj <- read.table("subject_test.txt",header=FALSE,sep ="")

# Load the test observation variables
# This is a dataset which represents the computations done on each observation

test.x <- read.table("x_test.txt",header=FALSE,sep ="",col.names=main.feat$V2)

# Load the test activity id
# This is an integer which represents what kind of activity they were doing (e.g., WALKING, SITTING, LAYING, etc)

test.y <- read.table("y_test.txt",header=FALSE,sep ="")

# Here we bind together the observation variables, the subject and the activity ID for the test observations

test.xy <- cbind(test.x,activity=test.y$V1,subject=test.subj$V1)

# Now we will change the working directory to train to load the test observations first

setwd("C:/R/UCI HAR Dataset/train/")

# Load the train subject # 
# This is a dataset which represents the person who made the observation

train.subj <- read.table("subject_train.txt",header=FALSE,sep ="")

# Load the train observation variables
# This is a dataset which represents the computations done on each observation

train.x <- read.table("x_train.txt",header=FALSE,sep ="",col.names=main.feat$V2)

# Load the test activity id
# This is an integer which represents what kind of activity they were doing (e.g., WALKING, SITTING, LAYING, etc)

train.y <- read.table("y_train.txt",header=FALSE,sep ="")

# Here we bind together the observation variables, the subject and the activity ID for the train observations

train.xy <- cbind(train.x,activity=train.y$V1,subject=train.subj$V1)

# Now we combine the test and train datasets

xy <- rbind(test.xy,train.xy)

# Next we use the SQLDF package to find the features which contain mean() or std()
# and put the results in a vector called stdmean 

stdmean <- c(sqldf("SELECT CAST(V1 AS DECIMAL) FROM [main.feat] WHERE V2 LIKE '%mean()%' OR V2 LIKE '%std()%'"))

# We create a results data frame which has renamed the columns based on the stdmean vector

results <- cbind(xy[,sapply(stdmean,as.numeric)],subject=xy$subject,activity=xy$activity)

# Next we look up the activity name based on the activity ID and replace the activity variable with the
# activity name

results$activity <- main.lbl[as.numeric(results$activity),2]

# We use the ddply function to apply the mean across the entire dataset 
# grouping by subject and activity
# This creates our tidy dataset

final <- ddply(results,c("subject","activity"), numcolwise(mean) )

# Write our tidy dataset to the R directory

write.table(final,"C:/R/TidyData.txt")


