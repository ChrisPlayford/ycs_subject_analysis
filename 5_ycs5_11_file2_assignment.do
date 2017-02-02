* 18th January 2017

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

* LCA - Sample 3 - subjects & covariates (4 Class Model)

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

* Rename latent class assignment probability fields and modal class assignment

rename _post_prob1 sample3_pp1		/* 1 Poor Grades */
rename _post_prob4 sample3_pp2		/* 2 Non-Science */
rename _post_prob2 sample3_pp3		/* 3 Science */
rename _post_prob3 sample3_pp4		/* 4 Good Grades */

label variable sample3_pp1 			"Sample 3 - LC1 Poor Grades - posterior probability"
label variable sample3_pp2 			"Sample 3 - LC2 Non-Science - posterior probability"
label variable sample3_pp3 			"Sample 3 - LC3 Science - posterior probability"
label variable sample3_pp4 			"Sample 3 - LC4 Good Grades - posterior probability"


recode _Best_Index 	(1 = 1 "Poor Grades") ///
					(4 = 2 "Non-Science") ///
					(2 = 3 "Science") ///
					(3 = 4 "Good Grades") ///
						, gen(sample3_modal_class)

label variable sample3_modal_class 	"Sample 3 - Modal Class Assignment"

drop _Best_Index
order lc_comb sample3_pp1 sample3_pp2 sample3_pp3 sample3_pp4, first
list

* Save dataset

save $path3\ycs5_to_11_sample3_lc_assign.dta, replace

***

* LCA - Sample 4 - alt subject grouping & covariates (5 Class Model)

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

matrix list r(gamma)
matrix list r(rho)

* Creating an ID variable to join on based on subject combinations

egen lc_comb2 = concat(english maths science humanity language othersub2), format(%9.0f)
destring lc_comb2, replace
label variable lc_comb2				"Sample 4 - Subject-Outcome pattern"
tab lc_comb2, missing
codebook lc_comb2

* A number of fields are not required

drop _ppcm* 	/* These are the overall latent class probabilities (gamma)*/
drop _draw*		/* Pseudo-draws */
drop english maths science humanity language othersub2 count

* Rename latent class assignment probability fields and modal class assignemtn

rename _post_prob* sample4_pp*
rename _Best_Index sample4_modal_class

label variable sample4_pp1 			"Sample 4 - LC1 Poor Grades - posterior probability"
label variable sample4_pp2 			"Sample 4 - LC2 Non-Science - posterior probability"
label variable sample4_pp3 			"Sample 4 - LC3 Science - posterior probability"
label variable sample4_pp4 			"Sample 4 - LC4 Good Grades - posterior probability"
label variable sample4_modal_class 	"Sample 4 - Modal Class Assignment"

label define best2 1 "Poor Grades" 2 "Non-Science" 3 "Science" 4 "Good Grades" 
label values sample4_modal_class best2

order lc_comb2, first
list

* Save dataset

save $path3\ycs5_to_11_sample4_lc_assign.dta, replace

clear

***

* Merging the latent class assingment datasets with the main data

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

* Sample 3 - Creating an ID variable to join on based on subject combinations

egen lc_comb = concat(english maths science humanity othersub), format(%9.0f)
destring lc_comb, replace force
replace lc_comb=. if sample3==0		/* Only want complete cases */

label variable lc_comb 				"Sample 3 - Subject-Outcome pattern"
tab1 lc_comb sample3, missing
codebook lc_comb sample3

* Sample 4 - Creating an ID variable to join on based on subject combinations

egen lc_comb2 = concat(english maths science humanity language othersub2), format(%9.0f)
destring lc_comb2, replace force
replace lc_comb2=. if sample4==0	/* Only want complete cases */

label variable lc_comb2				"Sample 4 - Subject-Outcome pattern"
tab1 lc_comb2 sample4, missing
codebook lc_comb2 sample4

* Merge Sample 3 Latent Class Assignement Information

merge m:1 lc_comb using $path3\ycs5_to_11_sample3_lc_assign.dta
drop _merge

* Merge Sample 4 Latent Class Assignement Information

merge m:1 lc_comb2 using $path3\ycs5_to_11_sample4_lc_assign.dta
drop _merge

* Brief investigation (different value ordering) - some leakage.

tab1 sample3_modal_class sample4_modal_class, mi
tab  sample3_modal_class sample4_modal_class, mi

***

* Set the weighting variable

svyset [pw=t1weight]
svydescribe

* Save dataset

save $path3\ycs5_to_11_set5.dta, replace

clear

* END *
