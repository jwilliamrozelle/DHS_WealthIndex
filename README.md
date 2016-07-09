#DHS Wealth Index for Honduras for XLS Form (ODK Collect) and associated code for R

##Differences from the DHS index
This version uses the same number for usual residents, total persons in household and the number who slept in HH last night. The official DHS separates in the questionnaire.

##Rural/Urban
At this time, the survey only calculates scores for rural areas of Honduras. In the future, Urban #s will also be added.

##Required packages
-xlsx
-gtools
-dplyr

##Running the code
-Run the code
-R will present a dialogue box- navigate to the xlsx file which contains the data from the XLS form
-After finding it, the code will run.
-Within R, descriptive statistics for the wealth index will be created, along with a histogram.
-When R has finished, it will present another dialogue box, this time, you must navigate to where you want to save the output excel file. It will contain the Household ID Rural (or urban, eventually) score, the Combined score, and the quintile.
