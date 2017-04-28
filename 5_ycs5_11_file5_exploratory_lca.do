* 8th February 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Comparison of 4 Class models by each cohort of YCS

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

* I have put these models in the '4 Class by Cohort' tab in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx'
* in the temp folder.

* 4 class model - all cohorts

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

tab sample3_modal_class

keep if sample3==1
count

tab t0cohort, mi

keep english maths science humanity othersub 
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

***

* 4 class model - each cohort 

foreach i of numlist 1990 1992 1993 1995 1997 1999 2001 {

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample3==1
keep if t0cohort==`i'
count

keep english maths science humanity othersub 
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

more
}

***

* 13th February 2017

* Test for measurement invariance using grouping variable (sex)

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample3==1
count

tab t0sex, mi

keep t0sex english maths science humanity othersub
order t0sex english maths science humanity othersub 
sort t0sex english maths science humanity othersub 

contract t0sex english maths science humanity othersub , zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* Standard Model

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* Adjusted BIC = -88376.847
* Entropy R-sqd = .70189519

***

* With measurement invariance

doLCA english maths science humanity othersub, ///
      nclass(4) ///
  	  groups(t0sex) ///
	  measurement("groups") ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* Adjusted BIC = 1014.8689
* Entropy R-sqd = .72611087

* Without measurement invariance

doLCA english maths science humanity othersub, ///
      nclass(4) ///
  	  groups(t0sex) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)
	  
* Adjusted BIC = 393.33577
* Entropy R-sqd = .70222724

***

* How does splitting the sample compare by two different methods?

* The results of this are in the 'Gender Split Sample' tab in 
* 'ycs5_11_lca_4class_20170110_cp_v1.xlsx' in the temp folder.

preserve
keep if t0sex==1

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)
	  
matrix list r(gamma)
matrix list r(rho)
restore

* Log-likelihood = -76316.426
* G-squared = 17.400941

preserve
keep if t0sex==2

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)
	  
matrix list r(gamma)
matrix list r(rho)
restore

* Log-likelihood = -84886.231
* G-squared = 10.312589

* Splitting the sample initially

forval x = 1/2 {
use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample3==1 & t0sex==`x'
count

tab t0sex, mi

keep english maths science humanity othersub
order english maths science humanity othersub 
sort english maths science humanity othersub 

contract english maths science humanity othersub , zero freq(count)
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

more
}

* Exactly the same

* Log-likelihood = -76316.426
* G-squared = 17.400941

* Log-likelihood = -84886.231
* G-squared = 10.312589

***

* 16th February 2017

* Test for measurement invariance using grouping variable (cohort)

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* The number of cases is insufficient for the model to converge using cohort
* Increase the sample size - use the full sample available

* Reminder:
* Sample 1 - all available subject information
* Sample 2 - all available subject information (alternative grouping)
* Sample 3 - subjects & covariates
* Sample 4 - alt subject grouping & covariates

keep if sample3==1
count

* I have had to collapse this to three periods (due to sparseness)

tab t0cohort, mi
recode t0cohort 1990/1992=1 1993/1995=2 1997/2001=3, gen(cohort)
tab t0cohort cohort, mi

* Restrict to variables of interest

keep cohort english maths science humanity othersub
order cohort english maths science humanity othersub 
sort cohort english maths science humanity othersub 

contract cohort english maths science humanity othersub , zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* Measurement Invariance

doLCA english maths science humanity othersub, ///
      nclass(4) ///
  	  groups(cohort) ///
	  measurement("groups") ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* G-squared = 1220.7389
* AIC = 1278.7389
* BIC = 1543.4026
* CAIC = 1572.4026
* Adjusted BIC = 1451.2399
* Entropy Raw = 31414.452
* Entropy R-sqd = .66644484

* Without measurement invariance

doLCA english maths science humanity othersub, ///
      nclass(4) ///
  	  groups(cohort) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* G-squared = 33.593616
* AIC = 171.59362
* BIC = 801.31081
* CAIC = 870.31081
* Adjusted BIC = 582.02712
* Entropy Raw = 27829.193
* Entropy R-sqd = .70451272

* I have put these models in the '4 Class by Cohort' tab in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx'
* in the temp folder.

***

* Running LCA on separate cohorts

foreach x in 1990 1992 1993 1995 1997 1999 2001 {
use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample3==1 & t0cohort==`x'
count

tab t0cohort, mi

keep english maths science humanity othersub
order english maths science humanity othersub 
sort english maths science humanity othersub 

contract english maths science humanity othersub , zero freq(count)
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

more
}

* I have put these models in the '4 Class by Cohort' tab in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx'
* in the temp folder.
	  
clear

* END *

