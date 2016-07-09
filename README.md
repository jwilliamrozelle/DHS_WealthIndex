#DHS Wealth Index for Honduras for XLS Form (ODK Collect) and associated code for R

##Differences from the DHS index
* This version uses the same number for usual residents, total persons in household and the number who slept in HH last night. The official DHS separates in the questionnaire.
* This version does not include the LAND variable, which has a **very** minor impact. The DHS instructions note that not including this will have little effect on the finding in the end. Ultimately, it simply would have added too much to the survey itself.

##ona.io
The code is based off my download from ona.io in xlsx format. Lines 32-60 of the script are dedicated to removing the superfluous parts of the variable names that come from the 'groups' in xls forms. If this is giving you trouble, you can delete lines 32-60, and use excel to rename variables from something like "table_list_own.QH141A" to simply "QH141A"

##Rural/Urban
At this time, the survey only calculates scores for rural areas of Honduras. In the future, Urban #s will also be added.

##Required packages
The required packages are listed below. Note that if they are not installed, the program will do so for you (if connected to the internet)
* xlsx
* gtools
* plyr
* dplyr

##Running the code
* Run HondurasWI_2011_12.R (Assumes you have R installed, if you don't- go to https://cran.r-project.org/ and find the appropriate version for your computer)
* R will present a dialogue box- navigate to the xlsx file which contains the data from the XLS form
* After finding it, the code will run.
* Within R, descriptive statistics for the wealth index will be created, along with a histogram.
* When R has finished, it will present another dialogue box, this time, you must navigate to where you want to save the output excel file, and type your desired name into the dialogue box such as 'WI_Scores.xlsx'. *Ensure that you type the extension .xlsx.* It will contain the Household ID Rural (or urban, eventually) score, the Combined score, and the quintile.

###If you have any issues or questions, please feel free to message me.
