---
title: "Codebook"
author: "Ralph Taite"
date: "Sunday, March 22, 2015"
output: html_document
---

# Codebook

## Purpose

The purpose of the codebook is to describe the variables, the data, and any transformations or work that were performed to clean up the data.

## Data

The datasets we are using are coming from activity data captured on a Samsung smartphone.  

They are divided into test and train observations.

They are as follows:

* activity_labels.txt - a cross reference between activity ID and activity description
* features.txt - a list of all observation variables
* subject_test.txt - a list of all subject #s for test observations
* subject_train.txt - a list of all subject #s for train observations
* x_test.txt - a list of all observations by observation variable for test observations
* x_train.txt - a list of all observations by observation variable for train observations 
* y_test.txt - a list of all activity IDs by observation for test observations
* y_test.txt - a list of all activity IDs by observation for train observations

## Variables

* main.lbl  - dataframe cross reference for the activity labels like WALKING, SITTING, LAYING, etc
* main.feat - dataframe for the 561 observation variables like fBodyBodyGyroJerkMag-mean()
* test.subj - dataframe for the subj from the test dataset who made the observation
* test.x    - dataframe for observations for the test dataset
* test.y    - dataframe for the activityID which maps to one of the main.lbl activities for the test dataset
* test.xy   - dataframe which combines test.x and test.y
* train.subj - dataframe for the subj from the train dataset who made the observation
* train.x    - dataframe for observations for the train dataset
* train.y    - dataframe for the activityID which maps to one of the main.lbl activities for the train dataset
* train.xy   - dataframe which combines train.x and train.y
* xy        - dataframe which combine the test.xy and train.xy dataframes
* stdmean   - vector of integers which represent the observations which are based solely on std() or mean()
* results   - dataframe which combines observation variables from stdmean with the activity and subject #
* final     - dataframe which is the result of grouping by activity and subject # and then taking the mean of  each observation variables

## Transformations

The following transformations are performed by my code:

*  Combining the train and test datasets
*  Replacing the activity name instead of the activity ID and then combining with the subject and observation variables into the xy data frame
*  Combining the subject with the activity and observation variables into the xy data frame
*  Removing all observation variable columns from the xy dataframe which are not std() or mean() related
