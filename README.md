# Getting-and-Cleaning-Data-Course-Project

This is the readme file for the Getting and Cleaning Data Course Project on Coursera. The goal of this project is to process raw data to prepare tidy data that can be used for later analysis.

## Raw data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information

For each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables (details below). 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Feature Selection

The features selected for this data set come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

## Tidy data

A txt file (avgsummary.txt) containing the average of each variable (measurement on the mean and standard deviation) for each activity and each subject, along with the activity name and subject identifier.

## How the scripts work

The file "run_analysis.R" contains the scripts need to transform the raw data into tidy data. Below is a description of the analysis performed by the code.

### 1) Read raw data from source files

Use the `read.table` function to read the source text files in and store them in individual data frames (same variable names with original txt files without extention):

- `activity_labels`: links between activity labels and their names.

- `features`: names of 561 features with time and frequency domain variables.

- `subject_test`: subject identifiers of the test set.

- `X_test`: test set (assign `features` to column names).

- `y_test`: activity labels of the test set.

- `subject_train`: subject identifiers of the training set.

- `X_train`: training set (assign `features` to column names).

- `y_train`: activity labels of the training set.

### 2) Merge, arrange and extract

- Use the `cbind` function to bind test and training sets to their respective subject identifiers and activity labels.

- Use the `rbind` function to merge the two resulting data frames (`test` and `train`) to create one data set `data`.

- Sort `data` by subject identifiers (`Subject`) and activity labels (`Activity`) using the `arrange` function in the `dplyr` package.

- Match the column names of `data` with substrings `"mean()"` and `"std()"` using the `grep` function to get column indices corresponding to measurements on the mean and standard deviation (`ind_mean_std`).

- Subset `data` with `ind_mean_std` to extract mean and standard deviation data (`data_mean_std`).

### 3) Use descriptive activity names to name the activities in the data set

Use a nested `for` loop to examine the activity label (integer) of each row in `data_mean_std` and compare the value of each iteration with each row in the linkage table `activity_labels`, then replace the integer value with the descriptive character string.

### 4) Relabel the data set with descriptive variable names

Use the `gsub` function to:

- Remove any numbers/spaces/parentheses attached to the feature variable names, and
- Replace any abbreviations with their full names for easier understanding (for example, `"Acceleration"` for `"Acc"`, etc.).

### 5) Create tidy data set with average of each variable for each activity and subject

- Use the `group_by` function to group `data_mean_std` by `Subject` and `Activity`.

- Pass the grouped data frame `group` and function call `funs(mean)` to the `summarize_each` function in order to compute the average of each column by the groups created above (`Subject` and `Activity`).

- Write the resulting data frame of averages `avgsummary` into a text file "avgsummary.txt" using the `write.table` function. This file contains the tidy data set required.