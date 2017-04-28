* 28th April 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Replication of YCS6 work using YCS5-YCS11

* Some additional charts following the Q-step talk on the 27th April 2017

* Adding confidence intervals around the point estimates (LCA models)

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

* Sample 1 LCA - all available subject information

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

keep if sample1==1
count

keep english maths science humanity othersub 
sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

* 4 Class Model

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

* Put the latent class probabilites and the conditional probabilites into matrices
* Contrary to the variable naming - these are standard errors not standard deviations (see manual)
	  
* Latent class probabilities & SEs
	  
matrix list r(gamma)
matrix a =  r(gamma)

matrix list r(gammaSTD)
matrix b =  r(gammaSTD)

* Conditional probabilities & SEs

matrix list r(rho)
matrix c1 = r(rho)
matrix c  = c1[6..10,1...]		/* Only want the second half of the matrix */
matrix drop c1
matrix list c

matrix list r(rhoSTD)
matrix d1 = r(rhoSTD)
matrix d  = d1[6..10,1...]		/* Only want the second half of the matrix */
matrix drop d1
matrix list d

* Concatenate the matrices and put on labels

matrix e = (a\c),(b\d)
matrix list e

matrix colnames e = "class1" "class2" "class4" "class3" "se1" "se2" "se4" "se3"
matrix rownames e = "1" "2" "3" "4" "5" "6"
matrix list e

* Convert matrix into dataset

clear
svmat e, names(col)
list

* Create new variables

gen sample = 1
gen n = 92082
gen var = _n

order sample n var class1 class2 class3 class4 se1 se2 se3 se4
list

* Save dataset

save $path2\temp\lca_charts_error_bars1.dta, replace
clear
matrix drop _all

***
 
* Sample 3 LCA - subjects & covariates

use $path3\ycs5_to_11_set4.dta, clear
numlabel _all, add

keep if sample3==1
count

keep english maths science humanity othersub 
sort english maths science humanity othersub

contract english maths science humanity othersub, zero freq(count)

cd C:\ado\plus\l\ 			/* Change this path to match the file location on your machine */

doLCA english maths science humanity othersub, ///
      nclass(4) ///
	  seed(100) ///
	  seeddraws(1500) ///
	  categories(2 2 2 2 2) ///
	  freq(count)

* Put the latent class probabilites and the conditional probabilites into matrices
* Contrary to the variable naming - these are standard errors not standard deviations (see manual)
	  
* Latent class probabilities & SEs
	  
matrix list r(gamma)
matrix a =  r(gamma)

matrix list r(gammaSTD)
matrix b =  r(gammaSTD)

* Conditional probabilities & SEs

matrix list r(rho)
matrix c1 = r(rho)
matrix c  = c1[6..10,1...]		/* Only want the second half of the matrix */
matrix drop c1
matrix list c

matrix list r(rhoSTD)
matrix d1 = r(rhoSTD)
matrix d  = d1[6..10,1...]		/* Only want the second half of the matrix */
matrix drop d1
matrix list d

* Concatenate the matrices and put on labels

matrix e = (a\c),(b\d)
matrix list e

matrix colnames e = "class1" "class2" "class4" "class3" "se1" "se2" "se4" "se3"
matrix rownames e = "1" "2" "3" "4" "5" "6"
matrix list e

* Convert matrix into dataset

clear
svmat e, names(col)
list

* Create new variables

gen sample = 3
gen n = 67937
gen var = _n

order sample n var class1 class2 class3 class4 se1 se2 se3 se4
list

* Save dataset

save $path2\temp\lca_charts_error_bars2.dta, replace
clear
matrix drop _all

***

* Append the datasets

use $path2\temp\lca_charts_error_bars1.dta, clear
append using $path2\temp\lca_charts_error_bars2.dta
list

* Labels  

label define varlab ///
1 "Latent Class Prob" ///
2 "English A*-C" ///
3 "Maths A*-C" ///
4 "Science A*-C" ///
5 "Humanity A*-C" ///
6 "Other Sub A*-C"

label values var varlab

label define sample1 ///
1 "All subject info,  n=92,082" ///
3 "Plus covariates, n=67,937"

label values sample sample1

***

* Create higher and lower intervals

forvalues i = 1/4 { 
	gen class`i'_hi = class`i' + (invttail(n-1,0.025)* se`i')
	gen class`i'_lo = class`i' - (invttail(n-1,0.025)* se`i')
}

* Save dataset

save $path2\temp\lca_charts_error_bars3.dta, replace
clear

***
				
* New graphs

* Latent Class probabilities

use $path2\temp\lca_charts_error_bars3.dta, clear

keep if sample==3
drop if var>1
list

* Reshape long

drop sample n
rename class*_hi hi*
rename class*_lo lo*
list

reshape long class se hi lo, i(var) j(lc)
list

***

* Latent Class Probability chart

twoway 	(bar class lc) ///
		(rcap hi lo lc, lcolor(black) ), ///
					legend(off) ///
					xlabel(	1 "Poor Grades" ///
							2 "Science" ///
							3 "Non-Science" ///
							4 "Good Grades") ///
					title("Latent Class Probabilities") ///
					ytitle("Probability") ///
					xtitle(" ") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

***

* Poor Grades

use $path2\temp\lca_charts_error_bars3.dta, clear

keep if sample==3
drop if var==1		/* Remove the latent class probabilities from the chart */

twoway 	(bar class1 var) ///
		(rcap class1_hi class1_lo var, lcolor(black) ) , ///
					legend(off) ///
					xlabel(	2 "English A*-C" ///
							3 "Maths A*-C" ///
							4 "Science A*-C" ///
							5 "Humanity A*-C" ///
							6 "Other Sub A*-C", alternate) ///
					title("Probabilities for Poor Grades Latent Class") ///
					ytitle("Probability") ///
					xtitle(" ") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

* Science

twoway 	(bar class2 var) ///
		(rcap class2_hi class2_lo var, lcolor(black) ) , ///
					legend(off) ///
					xlabel(	2 "English A*-C" ///
							3 "Maths A*-C" ///
							4 "Science A*-C" ///
							5 "Humanity A*-C" ///
							6 "Other Sub A*-C", alternate) ///
					title("Probabilities for Science Latent Class") ///
					ytitle("Probability") ///
					xtitle(" ") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

* Non-Science

twoway 	(bar class3 var) ///
		(rcap class3_hi class3_lo var, lcolor(black) ) , ///
					legend(off) ///
					xlabel(	2 "English A*-C" ///
							3 "Maths A*-C" ///
							4 "Science A*-C" ///
							5 "Humanity A*-C" ///
							6 "Other Sub A*-C", alternate) ///
					title("Probabilities for Non-Science Latent Class") ///
					ytitle("Probability") ///
					xtitle(" ") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

* Good Grades

twoway 	(bar class4 var) ///
		(rcap class4_hi class4_lo var, lcolor(black) ) , ///
					legend(off) ///
					xlabel(	2 "English A*-C" ///
							3 "Maths A*-C" ///
							4 "Science A*-C" ///
							5 "Humanity A*-C" ///
							6 "Other Sub A*-C", alternate) ///
					title("Probabilities for Good Grades Latent Class") ///
					ytitle("Probability") ///
					xtitle(" ") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))
					
clear

* END *
