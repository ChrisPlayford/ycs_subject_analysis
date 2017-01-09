* 6th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Inspection of the YCS Background Variables for consistency of variable naming

 global path5 "A:\data\YCS_Cohort_5_Download\stata8\"
 global path6 "A:\data\YCS_Cohort_6_Download\stata8\"
 global path7 "A:\data\YCS_Cohort_7_Download\stata8\"
 global path8 "A:\data\YCS_Cohort_8_Download\stata8\"
 global path9 "A:\data\YCS_Cohort_9_Download\stata8\"
global path10 "A:\data\YCS_Cohort_10_Download\stata8_se\"
global path11 "A:\data\YCS_Cohort_11_Download\stata8_se\"
global path12 "A:\data\YCS_Cohort_12_Download\stata8\"
global path13 "A:\data\YCS_Cohort_13_Download\stata9\"

 global path2 "A:\YCS\github_ycs_subject_analysis\"
 global path3 "A:\YCS\github_ycs_subject_analysis\data\"
 global path4 "A:\data\YCS_time_series\stata8\"
 
***

* Creating an Excel spreadsheet of the variables and variable labels

capture erase $path2\ycs_background_variables.xlsx

* YCS 5,7,8,9
 
use $path3\ycs5_789_background_vars.dta, clear
describe, replace
export excel using ///
	$path2\ycs_background_variables.xlsx, ///
		firstrow(varlabels) sheet("YCS5_789") sheetreplace


***

* YCS6
 
use $path3\ycs6_background_vars.dta, clear
describe, replace
export excel using ///
	$path2\ycs_background_variables.xlsx, ///
		firstrow(varlabels) sheet("YCS6") sheetmodify
		
***

* YCS10
 
use $path3\ycs10_background_vars.dta, clear
describe, replace
export excel using ///
	$path2\ycs_background_variables.xlsx, ///
		firstrow(varlabels) sheet("YCS10") sheetmodify

***
 
* YCS11
 
use $path3\ycs11_background_vars.dta, clear
describe, replace
export excel using ///
	$path2\ycs_background_variables.xlsx, ///
		firstrow(varlabels) sheet("YCS11") sheetmodify

clear

* END *
