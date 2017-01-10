* 10th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Initial Exploratory Analysis

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

* YCS 5-11 Dataset (includes class variables)

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

codebook, compact

* Exploratory LCA

keep if sample==1
count

keep english maths science humanity othersub 
tab1 english maths science humanity othersub, missing

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

return list

matrix list r(gamma)
matrix list r(rho)

* Putting this into a matrix (this has been updated in the software).

label variable _post_prob1 "Poor Grades LC1 Posterior Probability"
label variable _post_prob2 "Science LC2 Posterior Probability"
label variable _post_prob3 "Good Grades LC3 Posterior Probability"
label variable _post_prob4 "Arts LC4 Posterior Probability"
label variable _Best_Index "Most Probable Latent Class"

label define best 1 "Poor Grades" 2 "Science" 3 "Good Grades" 4 "Arts"
label values _Best_Index best

numlabel _all, add
tab _Best_Index 

list english maths science humanity othersub count _post_prob* _Best_Index

***

* Try again with all available cases

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

* This time - make the sample for all available subject information

mark    sample2
markout sample2		english ///
					maths ///
					science ///
					humanity ///
					othersub
tab sample2, mi

keep if sample2==1
count

keep english maths science humanity othersub 
tab1 english maths science humanity othersub, missing

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

return list

matrix list r(gamma)
matrix list r(rho)

clear

* I have put these initial models in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx' in the temp folder.

* END *
