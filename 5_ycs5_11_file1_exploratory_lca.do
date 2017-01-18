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

* Exploratory LCA - Sample 1 - all available subject information

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

codebook, compact

keep if sample1==1
count

keep english maths science humanity othersub 
tab1 english maths science humanity othersub, missing

sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 4 Class Model

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

***

* Exploratory LCA - Sample 2 - all available subject information (alternative grouping)

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample2==1
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

clear

***

* Exploratory LCA - Sample 3 - subjects & covariates

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample3==1
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

***

* Exploratory LCA - Sample 4 - alt subject grouping & covariates

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

clear

* I have put these initial models in the '4 Class Models' tab in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx' in the temp folder.

***

* 18th January 2017

* Explore the number of latent classes in each scenario

* YCS 5-11 Dataset (includes class variables)

* Exploratory LCA - Sample 1 - all available subject information

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

codebook, compact

keep if sample1==1
count

set more off

keep english maths science humanity othersub 
tab1 english maths science humanity othersub, missing

sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 1 Class Model

doLCA english maths science humanity othersub, ///
      nclass(1) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 2 Class Model

doLCA english maths science humanity othersub, ///
      nclass(2) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 3 Class Model

doLCA english maths science humanity othersub, ///
      nclass(3) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 4 Class Model

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 4 Class Model

doLCA english maths science humanity othersub, ///
      nclass(5) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* Exploratory LCA - Sample 2 - all available subject information (alternative grouping)

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample2==1
count

keep english maths science humanity language othersub2 
tab1 english maths science humanity language othersub2, missing

sort english maths science humanity language othersub2

contract english maths science humanity language othersub2, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 1 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(1) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 2 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(2) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 3 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(3) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 4 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 5 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(5) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

* 6 Class Model

doLCA english maths science humanity language othersub2, ///
      nclass(6) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2 2) ///
	  freq(count)

matrix list r(gamma)
matrix list r(rho)

clear

* I have put these initial models in the 'Number of Classes' tab in 'ycs5_11_lca_4class_20170110_cp_v1.xlsx' in the temp folder.

clear

* END *
