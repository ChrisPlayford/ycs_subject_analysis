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
matrix colnames n = ":1990" ":1992" ":1993" ":1995" ":1997" ":1999" ":2001" "Total"

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

* Table 6

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

estimates clear
capture matrix drop _all

* Summary figures

svy: mean t0examac if sample3==1
matrix a =  e(b)

svy: mean t0examaf if sample3==1
matrix b =  e(b)

svy: mean t0score2 if sample3==1
matrix c =  e(b)

svy: mean t0examst if sample3==1
matrix d =  e(b)

* By Latent Class

svy: mean t0examac if sample3==1, over(sample3_modal_class)
matrix e =  e(b)

svy: mean t0examaf if sample3==1, over(sample3_modal_class)
matrix f =  e(b)

svy: mean t0score2 if sample3==1, over(sample3_modal_class)
matrix g =  e(b)

svy: mean t0examst if sample3==1, over(sample3_modal_class)
matrix h =  e(b)

* Concatenate the sub-matrices

matrix i = (e\f\g\h),(a\b\c\d)

* Label the column and row names

matrix colnames i = ":1 Poor Grades" ":2 Science" ":3 Non-Science" ":4 Good Grades" "All"
matrix rownames i = "Mean number of A*–C passes" "Mean number of A*–F passes" "Mean GCSE points score" "Mean number of GCSEs studied"

* Round the values

forval i = 1/4 {
	forval j = 1/5 {
		matrix i[`i',`j'] = round(i[`i',`j'], 0.1)
}
}

* Export the matrix

matrix list i
putexcel A1=matrix(i, names) using "A:\YCS\github_ycs_subject_analysis\outputs\table6.xlsx", replace

***

* Table 7

estimates clear
capture matrix drop _all

* Summary

* English and Maths individually 

svy: proportion english if sample3==1
matrix a1 = e(b)
matrix a  = a1[1,2]

svy: proportion maths if sample3==1
matrix b1 = e(b)
matrix b  = b1[1,2]

* Joint English and Maths

gen eng_and_maths=1
replace eng_and_maths=2 if (english==2 & maths==2)

svy: proportion eng_and_maths if sample3==1
matrix c1 = e(b)
matrix c  = c1[1,2]

* Five or more A*-C passes

svy: proportion t0fiveac if sample3==1
matrix d1 = e(b)
matrix d  = d1[1,2]

* Five or more A*-C passes (inc English and Maths)

svy: proportion t0fiveac_em if sample3==1
matrix e1 = e(b)
matrix e  = e1[1,2]

***

* For each latent class

* English and Maths individually

svy: proportion english if sample3==1, over(sample3_modal_class)
matrix f1 = e(b)
matrix f  = f1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"]

svy: proportion maths if sample3==1, over(sample3_modal_class)
matrix g1 = e(b)
matrix g  = g1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"]

* Joint English and Maths

svy: proportion eng_and_maths if sample3==1, over(sample3_modal_class)
matrix h1 = e(b)
matrix h  = h1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"]

* Five or more A*-C passes

svy: proportion t0fiveac if sample3==1, over(sample3_modal_class)
matrix i1 = e(b)
matrix i  = i1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"]

* Five or more A*-C passes (inc English and Maths)

svy: proportion t0fiveac_em if sample3==1, over(sample3_modal_class)
matrix j1 = e(b)
matrix j  = j1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"]

* Concatenate the sub-matrices

matrix k = (f\g\h\i\j),(a\b\c\d\e)

* Label the column and row names

matrix colnames k = ":1 Poor Grades" ":2 Science" ":3 Non-Science" ":4 Good Grades" "All"
matrix rownames k = "GCSE English A*-C" "GCSE Maths A*-C" "Both GCSE Eng & Maths A*-C" "5+ A*-C passes" "5+ A*-C inc E & M"

* Round the values

forval i = 1/5 {
	forval j = 1/5 {
		matrix k[`i',`j'] = round(k[`i',`j'], 0.01)
}
}

* Export the matrix

matrix list k
putexcel A1=matrix(k, names) using "A:\YCS\github_ycs_subject_analysis\outputs\table7.xlsx", replace

***

* Table 8

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

estimates clear
capture matrix drop _all

* svy: tab sample3_modal_class
* svy: tab t0cohort sample3_modal_class, row

* Cohort

set more off
svy: proportion sample3_modal_class, over(t0cohort)
matrix a1 = e(b)
matrix a  = (a1["y1" , "_prop_1:1990".."_prop_1:2001"] \ a1["y1" , "_prop_2:1990".."_prop_2:2001"] \ a1["y1" , "_prop_3:1990".."_prop_3:2001"] \ a1["y1" , "_prop_4:1990".."_prop_4:2001"] )'

matrix colnames a = "1 Poor Grades" "2 Science" "3 Non-Science" "4 Good Grades"
matrix rownames a = ":1990" ":1992" ":1993" ":1995" ":1997" ":1999" ":2001"

* Sex

set more off
svy: proportion sample3_modal_class, over(t0sex)
matrix b1 = e(b)
matrix b  = (b1["y1" , "_prop_1:_subpop_1".."_prop_1:_subpop_2"] \ b1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_2"] \ b1["y1" , "_prop_3:_subpop_1".."_prop_3:_subpop_2"] \ b1["y1" , "_prop_4:_subpop_1".."_prop_4:_subpop_2"] )'

matrix rownames b = ":Boys" ":Girls"

* Ethnicity

set more off
svy: proportion sample3_modal_class, over(t0ethnic)
matrix c1 = e(b)
matrix c  = (c1["y1" , "_prop_1:_subpop_1".."_prop_1:_subpop_7"] \ c1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_7"] \ c1["y1" , "_prop_3:_subpop_1".."_prop_3:_subpop_7"] \ c1["y1" , "_prop_4:_subpop_1".."_prop_4:_subpop_7"] )'

matrix rownames c = ":White" ":Black" ":Indian" ":Pakistani" ":Bangladeshi" ":Other asian" ":Other response"

* Housing

set more off
svy: proportion sample3_modal_class, over(t0house)
matrix d1 = e(b)
matrix d  = (d1["y1" , "_prop_1:_subpop_1".."_prop_1:_subpop_3"] \ d1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_3"] \ d1["y1" , "_prop_3:_subpop_1".."_prop_3:_subpop_3"] \ d1["y1" , "_prop_4:_subpop_1".."_prop_4:_subpop_3"] )'

matrix rownames d = ":Owned" ":Rented" ":Other housing"

* Household Type

set more off
svy: proportion sample3_modal_class, over(t0stay)
matrix e1 = e(b)
matrix e  = (e1["y1" , "_prop_1:_subpop_1".."_prop_1:_subpop_4"] \ e1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_4"] \ e1["y1" , "_prop_3:_subpop_1".."_prop_3:_subpop_4"] \ e1["y1" , "_prop_4:_subpop_1".."_prop_4:_subpop_4"] )'

matrix rownames e = ":Lives with both parents" ":Only lives with mother" ":Only lives with father" ":Other household"

* NS-SEC

set more off
svy: proportion sample3_modal_class, over(t0par_nssec2)
matrix f1 = e(b)
matrix f  = (f1["y1" , "_prop_1:_subpop_1".."_prop_1:_subpop_8"] \ f1["y1" , "_prop_2:_subpop_1".."_prop_2:_subpop_8"] \ f1["y1" , "_prop_3:_subpop_1".."_prop_3:_subpop_8"] \ f1["y1" , "_prop_4:_subpop_1".."_prop_4:_subpop_8"] )'

matrix rownames f = ":NS1 1" ":NS1 2" ":NS2" ":NS3" ":NS4" ":NS5" ":NS6" ":NS7"

* All

svy: proportion sample3_modal_class
matrix g1 = e(b)
matrix rownames g1 = "All"

* n

matrix g2 = e(b) * e(N)
matrix rownames g2 = "n"

forval j = 1/4 {
		matrix g2[1,`j'] = round(g2[1,`j'])
}

matrix list g2

* Concatenate the sub-matrices

matrix h = (a\b\c\d\e\f\g1\g2)

* Round the values

forval i = 1/32 {
	forval j = 1/4 {
		matrix h[`i',`j'] = round(h[`i',`j'], 0.01)
}
}

* Export the matrix

matrix list h
putexcel A1=matrix(h, names) using "A:\YCS\github_ycs_subject_analysis\outputs\table8.xlsx", replace

***

* Table 9

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, rem

mlogit sample3_modal_class ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight], base(4) 
est store a

esttab a using "A:\YCS\github_ycs_subject_analysis\outputs\table9.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) pr2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("Multinomial Logit") ///
	wide staraux nogaps noparentheses replace
	
* Change base category to compare middle attainment latent groups

mlogit sample3_modal_class ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight], base(2) 
est store b

esttab b using "C:\temp\github_ycs_subject_analysis\outputs\table9a.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) pr2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("Multinomial Logit") ///
	unstack wide staraux nogaps noparentheses replace

***

* Figure 1

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, rem

* Check to make sure quasi-variance installed

* ssc install qv

* Check the numeric labels on the latent group variable

numlabel _all, add
tab sample3_modal_class, mi
numlabel _all, rem

***

* Estimate 3 separate models to replicate the mlogit then export the matrices

forvalues i = 1/3 {

	* Estimate mlogit model

	mlogit sample3_modal_class ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					if sample3_modal_class==`i' | sample3_modal_class==4 ///
						[pw=t1weight], base(4) 	

	* These are the coefficients for the comparison group
					
	qv ib2.t0par_nssec2

	* Matrix to save the results of the quasi-variances

	mat lowerq`i'	=	e(qvlb)
	mat upperq`i'	=	e(qvub)
	svmat lowerq`i', names(lowerq`i')
	svmat upperq`i', names(upperq`i')
	gen BETAS`i'	=	(lowerq`i'+upperq`i')/2

}

***

* Group (for social class variable)

gen class1 = _n in 1/8
gen class2 = class1 + 0.1
gen class3 = class1 + 0.2

* Graph this

set scheme s1mono

twoway ///
(scatter BETAS1 class1, msymbol(smcircle) mlcolor(black) mfcolor(white)  msize(medium)) ///
(scatter BETAS2 class2, msymbol(smdiamond) mlcolor(black) mfcolor(white)  msize(medium))  ///
(scatter BETAS3 class3, msymbol(smsquare) mlcolor(black) mfcolor(white)  msize(medium))  ///
(rspike upperq1 lowerq1 class1, blcolor(black) blwidth(medium)) ///
(rspike upperq2 lowerq2 class2, blcolor(black) blwidth(medium)) ///
(rspike upperq3 lowerq3 class3, blcolor(black) blwidth(medium)) ///
, ///
	title("Latent Educational Group Membership" "Parental Occupation (NS-SEC)", size(large) justification(center) ) ///
	subtitle("Multinomial Logistic Regression Coefficients" "(With Quasi Variance Comparison Intervals)" " ", size(small) justification(center) ) ///
	xlabel(1 "1.1" 2 "1.2" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7") ///
	xtitle("NS-SEC" "Parental Occupation") ///
	ytitle("Coefficient") ///
	yline(0) ///
	legend(order(	1 "Poor Grades" ///
					2 "Science" ///
					3 "Non-Science" ) rows(1)) ///
	note(	" " ///
			"All pupils gaining a GCSE pass at grades A*-G, n=67,937, weighted data, YCS Cohorts 5-11." ///
			" " ///
			"Other variables includes in the model:" ///
			"Year completed compulsory schooling, Gender, Ethnicity, Housing Tenure, Household Type")

* Export the graph

graph export "C:\temp\github_ycs_subject_analysis\outputs\lclass_nssec_mlogit.png", as(png) replace

clear

* END *
