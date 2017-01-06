* 6th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Inspection of the YCS Subject information for consistency of variable naming

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

capture erase "A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx"
 
* YCS5
 
use $path3\ycs5_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS5") sheetreplace

***
 
* YCS6
 
use $path3\ycs6_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS6") sheetmodify
		
***
 
* YCS7
 
use $path3\ycs7_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS7") sheetmodify

***
 
* YCS8
 
use $path3\ycs8_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS8") sheetmodify

***
 
* YCS9
 
use $path3\ycs9_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS9") sheetmodify
		
***
 
* YCS10
 
use $path3\ycs10_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS10") sheetmodify

***
 
* YCS11
 
use $path3\ycs11_gsce_subjects.dta, clear
describe, replace
export excel using ///
	"A:\YCS\github_ycs_subject_analysis\temp\ycs_gcse_subjects_variables.xlsx", ///
		firstrow(varlabels) sheet("YCS11") sheetmodify

clear

* END *
