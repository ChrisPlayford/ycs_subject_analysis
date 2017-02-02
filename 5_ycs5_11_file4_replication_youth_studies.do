* 1st February 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Replication of YCS6 work using YCS5-YCS11

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

* For tables to be replicated, see:
* http://www.tandfonline.com/doi/pdf/10.1080/13676261.2015.1052049

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* Table 1. Agglomerate measures of GCSE attainment

set more off
estimates clear
capture matrix drop _all

svy: tab t03cat if sample3==1
matrix a =  e(b)

svy: tab t03cat_em if sample3==1
matrix b =  e(b)

svy: mean t0score2 if sample3==1		/* This is capped at 84 points */ 
matrix c =  e(b)

svy: mean t0examst if sample3==1
matrix d =  e(b)

svy: mean t0examac if sample3==1
matrix e =  e(b)

svy: mean t0examaf if sample3==1
matrix f =  e(b)

***

* Matrix of estimates (horizontally concatenated and transposed)

matrix g = (a,b,c,d,e,f)'

* Rownames for matrix

matrix rownames g = "0 A*-C passes" "1-4 A*-C passes" "5+ A*-C passes" "0 A*-C inc E & M" "1-4 A*-C inc E & M" "5+ A*-C inc E & M" "Mean GCSE points score" "Mean number of GCSEs studied" "Mean number of A*–C passes" "Mean number of A*–F passes"

* Rounding the values

forval i = 1/6 {
matrix g[`i',1] = round(g[`i',1], 0.01)
}

forval i = 7/10 {
matrix g[`i',1] = round(g[`i',1], 0.1)
}

* Exporting the matrix into excel.

matrix list g
putexcel A2=matrix(g, rownames) using "A:\YCS\github_ycs_subject_analysis\outputs\table1a.xlsx", replace

***

* Break this down by YCS cohort

* This was useful: 
* http://www.statalist.org/forums/forum/general-stata-discussion/general/1295041-storing-cell-counts-of-survey-data
* http://www.philender.com/courses/multivariate/notes/matstata.html

set more off
svy: tab t03cat    t0cohort if sample3==1, col
svy: tab t03cat_em t0cohort if sample3==1, col

* Have to use svy: proportion to store column percentages in matrices.

estimates clear

svy: proportion t03cat if sample3==1, over(t0cohort)
matrix h1 = e(b)

matrix h = h1["y1" , "_prop_1:1990".."_prop_1:2001"] \ h1["y1" , "_prop_2:1990".."_prop_2:2001"] \ h1["y1" , "_prop_3:1990".."_prop_3:2001"]

svy: proportion t03cat_em if sample3==1, over(t0cohort)
matrix i1 = e(b)

matrix i = i1["y1" , "_prop_1:1990".."_prop_1:2001"] \ i1["y1" , "_prop_2:1990".."_prop_2:2001"] \ i1["y1" , "_prop_3:1990".."_prop_3:2001"]

svy: mean t0score2 if sample3==1, over(t0cohort)		/* This is capped at 84 points */ 
matrix j = e(b)

svy: mean t0examst if sample3==1, over(t0cohort)
matrix k = e(b)

svy: mean t0examac if sample3==1, over(t0cohort)
matrix l = e(b)

svy: mean t0examaf if sample3==1, over(t0cohort)
matrix m = e(b)

* Matrix of estimates (vertically and horizontally concatenated)

matrix n = (h\i\j\k\l\m),g

* Rownames for matrix

matrix rownames n = "0 A*-C passes" "1-4 A*-C passes" "5+ A*-C passes" "0 A*-C inc E & M" "1-4 A*-C inc E & M" "5+ A*-C inc E & M" "Mean GCSE points score" "Mean number of GCSEs studied" "Mean number of A*–C passes" "Mean number of A*–F passes"
matrix colnames n = "1990" "1992" "1993" "1995" "1997" "1999" "2001" "Total"

* Not sure why the column names cannot be overwritten.

* Rounding the values

forval i = 1/6 {
	forval j = 1/8 {
		matrix n[`i',`j'] = round(n[`i',`j'], 0.01)
}
}

forval i = 7/10 {
	forval j = 1/8 {
		matrix n[`i',`j'] = round(n[`i',`j'], 0.1)
}
}

* Exporting the matrix into excel.

matrix list n
putexcel A1=matrix(n, names) using "A:\YCS\github_ycs_subject_analysis\outputs\table1b.xlsx", replace

***

* Table 2 - (1 = D-G) (2 = A*-C)

set more off
tab1 english maths science humanity othersub if sample3==1, missing

***

* Table 3

* 1 ENGLISH

gen fivepass_eng=0
replace fivepass_eng=1 if (t0fiveac==1 & english==2)
tab1 fivepass_eng t0fiveac, missing

* 2 MATHS

gen fivepass_maths=0
replace fivepass_maths=1 if (t0fiveac==1 & maths==2)
tab1 fivepass_maths t0fiveac, missing

* 3 SCIENCE

gen fivepass_sci=0
replace fivepass_sci=1 if (t0fiveac==1 & science==2)
tab1 fivepass_sci t0fiveac, missing

* 4 HUMANITY

gen fivepass_hum=0
replace fivepass_hum=1 if (t0fiveac==1 & humanity==2)
tab1 fivepass_hum t0fiveac, missing

* 5 OTHER

gen fivepass_other=0
replace fivepass_other=1 if (t0fiveac==1 & othersub==2)
tab1 fivepass_other t0fiveac, missing

tetrachoric fivepass_eng fivepass_maths fivepass_sci fivepass_hum fivepass_other if sample3==1
matrix list r(Rho)

drop fivepass_eng fivepass_maths fivepass_sci fivepass_hum fivepass_other

***

* Table 4 - Comparing the Latent Class Models

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample3==1
count

keep english maths science humanity othersub 
tab1 english maths science humanity othersub, missing

sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)
list, clean

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 2 - 5 Class Models

capture matrix drop _all

forval i = 2/5 {
	qui: doLCA english maths science humanity othersub, ///
		nclass(`i') ///
		seed(100) ///
		seeddraws(1500) ///
		categories(2 2 2 2 2) ///
		freq(count)
	
	matrix a`i' = r(Gsquared)
	matrix b`i' = r(loglikelihood) * -2
	matrix c`i' = r(df)
	matrix d`i' = r(EntropyRsqd)
	matrix e`i' = r(aic)
	matrix f`i' = r(bic)
	matrix g`i' = r(AdjustedBIC)
	matrix h`i' = a`i',b`i',c`i',d`i',e`i',f`i',g`i'	
}

* Concatenate matrices

matrix j = h2\h3\h4\h5

* Rownames for matrix

matrix colnames j = "G-squared" "Deviance" "df" "Entropy R-squared" "AIC" "BIC" "adj BIC"
matrix rownames j = "2 group" "3 group" "4 group" "5 group"

* Rounding the values

forval i = 1/4 {
	forval j = 1/2 {
		matrix j[`i',`j'] = round(j[`i',`j'], 0.1)
}
}

forval i = 1/4 {
		matrix j[`i',4] = round(j[`i',4], 0.01)
}

forval i = 1/4 {
	forval j = 5/7 {
		matrix j[`i',`j'] = round(j[`i',`j'], 0.1)
}
}

* Exporting the matrix into excel.

matrix list j
putexcel A1=matrix(j, names) using "A:\YCS\github_ycs_subject_analysis\outputs\table4.xlsx", replace

***

* Table 5

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

tab sample3_modal_class

* 4 class model

keep if sample3==1
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

***

clear

* END *
