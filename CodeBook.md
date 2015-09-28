# Getting-and-Cleaning-Data-Course-Project - Code Book

This code book describes the variables/data, and any transformations or work that was performed to clean up the data.

## Read from raw data

- `activity_labels`: links between activity labels and their names. The data frame contains 6 rows corresponding to 6 activities, and 2 columns showing labels and names respectively.

- `features`: names of 561 features with time and frequency domain variables (refer to README.md for more details). The data frame contains 1 single column and 561 rows, each contains the label and the name of the feature.

- `subject_test`: subject identifiers of the test set. The data frame contains 2947 rows and 1 single column (named "`Subject`"). Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- `X_test`: test set. The data frame contains 2947 rows (1 row for 1 window sample observation) and 561 columns (1 column for 1 feature). **The numbers are normalized and bounded within [-1,1], hence the unit is 1 (same for all following data frames derived from it).**

- `y_test`: activity labels of the test set. The data frame contains 2947 rows and 1 single column (named "`Activity`"). Each row labels the activity for each window sample. Its range is from 1 to 6.

- `subject_train`: subject identifiers of the training set. The data frame contains 7352 rows and 1 single column (named "`Subject`"). Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- `X_train`: training set. The data frame contains 7352 rows (1 row for 1 window sample observation) and 561 columns (1 column for 1 feature). **The numbers are normalized and bounded within [-1,1], hence the unit is 1 (same for all following data frames derived from it).**

- `y_train`: activity labels of the training set. The data frame contains 7352 rows and 1 single column (named "`Activity`"). Each row labels the activity for each window sample. Its range is from 1 to 6.

## Merge, arrange, extract and rename

- `test`: data frame of 2947 rows and 563 columns obtained by cbinding subject identifiers (`subject_test`) and activity labels (`y_test`) with test set (`X_test`).

- `train`: data frame of 7352 rows and 563 columns obtained by cbinding subject identifiers (`subject_train`) and activity labels (`y_train`) with test set (`X_train`).

- `data`: data frame of 10299 rows and 563 columns obtained by rbinding `test` and `train` and sorting by its two leftmost columns (`Subject` and `Activity`).

- `ind_mean_std`: vector of 66 integers corresponding to column indices for measurements on the mean and standard deviation.

- `data_mean_std`: data frame of 10299 rows and 68 columns corresponding to measurements on the mean and standard deviation, plus the subject identifiers and activity (labels before renaming and names after renaming) on the left.

## Create tidy data set

- `group`: data frame of 10299 rows and 68 columns obtained by grouping `data_mean_std` by `Subject` and `Activity`.

- `avgsummary`: data frame of 180 rows and 68 column containing the mean of each feature variable for each subject and activity. Each row corresponds to a combination of subject and activity (there are 30 * 6 = 180 combinations). The first two columns are subject identifiers and activity names. The remaining 66 columns correspond to the 66 variables.

- avgsummary.txt: output file generated from `avgsummary` corresponding to the tidy data set.