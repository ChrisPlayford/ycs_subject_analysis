* 6th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS 5,7,8,9 Preparation of respondent background information

* The location of the folder containing the YCS cohorts 5,7,8,9 data

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

clear
set more off

***

* SN5765 Dataset - Delete data from YCS1-4 & YCS10.

use $path4\ew_core.dta, clear

tab t0cohort t0source, mi

keep if t0cohort==1990 | ///
		t0cohort==1993 | ///
		t0cohort==1995 | ///
		t0cohort==1997

tab t0cohort t0source, mi

* YCS10 has been removed because of the lack of an ID variable in SN4571 to link the subject info on.

***

* Change label on t0dadsoc and t0mumsoc

codebook t0dadsoc t0mumsoc

label variable t0dadsoc "SOC90 code of fathers’ occupation"
label variable t0mumsoc "SOC90 code of mothers’ occupation"

***

* A subset of variables has been retained which is common to YCS6, YCS10 and YCS11.

keep 	t0cohort ///
		t0nation ///
		t0caseid ///
		t0source ///
		t1weight ///
		t2weight ///
		t3weight ///
		t0schtyp ///
		t0sex ///
		t0stay ///
		t0ethnic ///
		t0house ///
		t0dadpce ///
		t0mumpce ///
		t0dadalv ///
		t0mumalv ///
		t0daddeg ///
		t0mumdeg ///
		t0dadjob ///
		t0mumjob ///
		t0truant ///
		t1att1 ///
		t1att2 ///
		t1att3 ///
		t0region ///
		t0dadsoc ///
		t0mumsoc ///
		t0dadse ///
		t0mumse ///
		t0gor
		
describe

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs5_789_background_vars.dta, replace

clear

* END * 


