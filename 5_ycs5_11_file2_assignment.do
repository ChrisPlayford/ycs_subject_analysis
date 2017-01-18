* 10th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Assignment of cases to latent classes

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

* LCA - Sample 3 - subjects & covariates

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample3==1
count

keep english maths science humanity othersub 
* tab1 english maths science humanity othersub, missing

sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* Creating an ID variable to join on based on subject combinations

egen lc_comb = concat(english maths science humanity othersub), format(%9.0f)
destring lc_comb, replace
label variable lc_comb 				"Sample 3 - Subject-Outcome pattern"
tab lc_comb, missing
codebook lc_comb

* A number of fields are not required

drop _ppcm* 	/* These are the overall latent class probabilities (gamma)*/
drop _draw*		/* Pseudo-draws */
drop english maths science humanity othersub count

* Rename latent class assignment probability fields and modal class assignemtn

rename _post_prob* sample3_pp*
rename _Best_Index sample3_modal_class

label variable sample3_pp1 			"Sample 3 - LC1 Poor Grades - posterior probability"
label variable sample3_pp2 			"Sample 3 - LC2 Science - posterior probability"
label variable sample3_pp3 			"Sample 3 - LC3 Good Grades - posterior probability"
label variable sample3_pp4 			"Sample 3 - LC4 Arts - posterior probability"
label variable sample3_modal_class 	"Sample 3 - Modal Class Assignment"

label define best 1 "Poor Grades" 2 "Science" 3 "Good Grades" 4 "Arts"
label values sample3_modal_class best

order lc_comb, first
list

* Save dataset

save $path3\ycs5_to_11_sample3_lc_assign.dta, replace

***

* LCA - Sample 4 - alt subject grouping & covariates

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample4==1
count

keep english maths science humanity language othersub2 
tab1 english maths science humanity language othersub2, missing

sort english maths science humanity language othersub2

contract english maths science humanity language othersub2, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 4 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

return list

matrix list r(gamma)
matrix list r(rho)

* Repeat the steps above for this sample.

clear

* END *
