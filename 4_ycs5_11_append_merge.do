* 6th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Appending and merging the files created for individual YCS cohorts

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

* APPENDING 
* YCS 5,7,8,9 appending GCSE subject information

* YCS5

use $path3\ycs5_gsce_subjects.dta, clear
count

* Drop the summary variables as these exist in SN5765
* I created these as a check for consistency with SN5765

drop t0examst t0examaf t0examac t0score

***

* Append YCS7

append using $path3\ycs7_gsce_subjects.dta, keep(t0cohort t0caseid t0gc*)
count

tab t0cohort, mi

***

* Append YCS8

append using $path3\ycs8_gsce_subjects.dta, keep(t0cohort t0caseid t0gc*)
count

tab t0cohort, mi

***

* Append YCS9

append using $path3\ycs9_gsce_subjects.dta, keep(t0cohort t0caseid t0gc*)
count

tab t0cohort, mi

***

* Sort Variable Order and Dataset

order *, sequential
order t0cohort t0caseid, first

* Save dataset

save $path3\ycs5_789_gcse_subjects.dta, replace
clear

***

* MERGING

* Merging Respondent background information with GCSE subject information

* YCS 5,7,8,9 Merging respondent background information

use $path3\ycs5_789_background_vars.dta, clear
count

merge 1:1 t0cohort t0caseid using $path3\ycs5_789_gcse_subjects.dta

drop _merge
tab t0cohort, mi

* Save dataset

save $path3\ycs5_789_merged.dta, replace
clear

***

* YCS6 Merging respondent background information

use $path3\ycs6_background_vars.dta, clear
count

merge 1:1 t0caseid using $path3\ycs6_gsce_subjects.dta

drop _merge
tab t0cohort, mi

* Save dataset

save $path3\ycs6_merged.dta, replace
clear

***

* YCS10 Merging respondent background information

use $path3\ycs10_background_vars.dta, clear
count

merge 1:1 ycs10_id using $path3\ycs10_gsce_subjects.dta

drop _merge
tab t0cohort, mi

* Save dataset

save $path3\ycs10_merged.dta, replace
clear

***

* YCS11 Merging respondent background information

use $path3\ycs11_background_vars.dta, clear
count

merge 1:1 t0caseid using $path3\ycs11_gsce_subjects.dta

drop _merge
tab t0cohort, mi

* Save dataset

save $path3\ycs11_merged.dta, replace
clear

***

* APPENDING
* Appending all the merged datasets for YCS cohorts 5-11.

use $path3\ycs5_789_merged.dta, clear
tab t0cohort, mi

set more off
append using $path3\ycs6_merged.dta
append using $path3\ycs10_merged.dta
append using $path3\ycs11_merged.dta

tab t0cohort t0source, mi

* Ordering the variables

order t0gc*, seq last
order ycs10_id, after(t0caseid)

order 	t0dadsoc2000 ///
		t0mumsoc2000 ///
		ycs11_t0dad_nssec ///
		ycs11_t0mum_nssec, ///
			after(t0mumsoc)

order	t0gor, after(t0region)
			
order	t0dadse t0mumse, after(t0mumjob)
			
order 	t0gc1eng ///
		t0gc2math ///
		t0gc3his ///
		t0gc4geo ///
		t0gc5fre ///
		t0gc6cdt ///
		t0gc7bio ///
		t0gc8phy ///
		t0gc9che ///
		t0gc10sci ///
		t0gc12othsci ///
		t0gc13othhum ///
		t0gc14othlan ///
		t0gc15re ///
		t0gc16arts ///
		t0gc17ped ///
		t0gc18other, ///
			after(t0score)

codebook, compact

* The dataset is quite large because of the retention of string variables (raw GCSEs).

save $path3\ycs5_to_11_set1.dta, replace

***

* A reduced dataset - removing the string variables containing the raw subject grade information

use $path3\ycs5_to_11_set1.dta, clear

drop t0gcres_raw*
describe

save $path3\ycs5_to_11_set2.dta, replace

clear

* END *
