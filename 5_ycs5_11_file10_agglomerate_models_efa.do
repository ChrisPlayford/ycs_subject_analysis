* 15th July 2019

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Agglomerate models YCS5-YCS11
* Factor analysis to compare with LCA and GSEM

* Different file paths - local machines

* C:\temp
* U:\work\Research\UKHLS_NPD_Latent_Class_Analysis

 global path5 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_5_Download\stata8\"
 global path6 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_6_Download\stata8\"
 global path7 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_7_Download\stata8\"
 global path8 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_8_Download\stata8\"
 global path9 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_9_Download\stata8\"
global path10 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_10_Download\stata8_se\"
global path11 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_11_Download\stata8_se\"
global path12 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_12_Download\stata8\"
global path13 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_Cohort_13_Download\stata9\"

 global path2 "C:\temp\github_ycs_subject_analysis\"
 global path3 "C:\temp\github_ycs_subject_analysis\data\"
*global path3 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\data\"
 global path4 "C:\temp\github_ycs_subject_analysis\raw_data\YCS_time_series\stata8\"

clear
set more off

***

* Model 1: 5+ GCSE A* to C logit

estimates clear

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, rem

* Latent class sample

keep if sample3==1
count

codebook, compact

* Outcome: Gained 5+ GCSE A*-C passes

tab t0fiveac, mi

* Logistic regression model

logit t0fiveac	i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight]
est store a

***

* Model 2: 5+ A*-C with English Maths

* Outcome: Gained 5+ GCSE A*-C passes (inc. Englishs and Maths)

tab t0fiveac_em, mi

* Logistic regression model

logit t0fiveac_em	i.t0cohort ///
					ib2.t0sex ///
					i.t0ethnic ///
					i.t0house ///
					i.t0stay ///
					ib2.t0par_nssec2 ///
						[pw=t1weight]
est store b

* Export estimates from models

esttab a b using "$path2\outputs\agg_models_table1.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) pr2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("Logit 5+ A*-C" "Logit 5+ A*-C EM") ///
	wide staraux nogaps noparentheses replace

***

* Model 3: Count A* C - zip model

* Outcome: Count of number of A*-C GCSE passes

codebook t0examac

hist t0examac

* Outcome: Zero-Inflated Poisson model

* See: https://stats.idre.ucla.edu/stata/dae/zero-inflated-poisson-regression/

zip t0examac 	i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 [pw=t1weight], ///
					inflate(i.t0cohort ///
							ib2.t0sex ///
							i.t0ethnic ///
							i.t0house ///
							i.t0stay ///
							ib2.t0par_nssec2 )
est store c

esttab c using "$path2\outputs\agg_models_table2.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("ZIP Model") ///
	wide staraux nogaps noparentheses replace

fitstat
estat ic

* Number of obs     =     67,937
* Nonzero obs       =     61,361
* Zero obs          =      6,576


* Compare this with a poisson regression model

quietly: poisson t0examac 	i.t0cohort ///
							ib2.t0sex ///
							i.t0ethnic ///
							i.t0house ///
							i.t0stay ///
							ib2.t0par_nssec2 ///
								[pw=t1weight]
fitstat
estat ic

* Lower BIC for ZIP model

* ZIP		BIC	-440754.847
* Poisson	BIC	-396232.395
								
* Outcome: Negative binomial regression model

* See: https://stats.idre.ucla.edu/stata/dae/negative-binomial-regression/

nbreg t0examac i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight]

***

* Model 4: GCSE score (truncated)

* Outcome: GCSE points score (truncated)

codebook t0score2

* Linear regression model

reg t0score2 	i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight]
est store d

esttab d using "$path2\outputs\agg_models_table3.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) r2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("GCSE Points Score") ///
	wide staraux nogaps noparentheses replace

***

* Factor analysis

* Check variables on analytic sample

estimates clear
use $path3\ycs5_to_11_set5.dta, clear

keep if sample3==1
count

***

* Construct highest score variables for subject groupings

* 1) English

tab t0gc1eng_sc english, mi

egen english_sc = anyvalue (t0gc1eng_sc), v(0/7)
label variable english_sc "Highest Score in GCSE English subjects"
tab1 t0gc1eng_sc english_sc, missing

* 2) Maths

tab t0gc2math_sc maths, mi

egen maths_sc = anyvalue (t0gc2math_sc), v(0/7)
label variable maths_sc "Highest Score in GCSE Maths subjects"
tab1 t0gc2math_sc maths_sc, missing

* 3) Science

egen science_sc = rmax (t0gc7bio_sc t0gc8phy_sc t0gc9che_sc t0gc10sci_sc t0gc12othsci_sc)
label variable science_sc "Highest Score in GCSE Science subjects"
tab science_sc science, missing

* 4) Humanity

egen humanity_sc = rmax (t0gc3his_sc t0gc4geo_sc t0gc13othhum_sc t0gc15re_sc)
label variable humanity_sc "Highest Score in GCSE Humanity subjects"
tab humanity_sc humanity, missing

* 5) Other Subject

egen othersub_sc = rmax (t0gc5fre_sc t0gc6cdt_sc t0gc14othlan_sc t0gc16arts_sc t0gc17ped_sc t0gc18other_sc)
label variable othersub_sc "Highest Score in GCSE Other subjects"
tab othersub_sc othersub, missing

***

* These are the score variables for each of the 5 subject groupings

codebook english_sc maths_sc science_sc humanity_sc othersub_sc, compact

* Correlation between these variables

corr english_sc maths_sc science_sc humanity_sc othersub_sc

***

* Fit factor analysis and rotate

* Principal Components

factor english_sc maths_sc science_sc humanity_sc othersub_sc, pcf

* Factor analysis

factor english_sc maths_sc science_sc humanity_sc othersub_sc
rotate

* Iterated Principal Factors

factor english_sc maths_sc science_sc humanity_sc othersub_sc, ipf factors(2)
rotate

* These give broadly similar solutions

***

* ML Factor Analysis - this will be the reported version

estimates clear

factor english_sc maths_sc science_sc humanity_sc othersub_sc, ml
est store e

* Predict the factor loadings for the unrotated solution

capture drop f1 f2
predict f1 f2

rotate, varimax
est store f

* Need to produce a summary of the number of factors - table 1

estat factors
matrix fa = r(stats)

matrix colnames fa = "Log Likelihood" "DF Model" "DF Rem" "AIC" "BIC"
matrix rownames fa = "1 Factor Model" "2 Factor Model"

* Round the values in the matrix

forval i = 1/2 {
	forval j = 1/5 {
		matrix fa[`i',`j'] = round(fa[`i',`j'], 0.1)
}
}

matrix list fa

* Export the matrix into an RTF file

esttab matrix(fa) using "$path2\outputs\fa_models_table1.rtf", ///
	nomtitle replace
	
estat structure		/* This repeats the factor correlations */

* See the following for exporting the results from a factor analysis:
* http://repec.org/bocode/e/estout/advanced.html#advanced404

esttab f using "$path2\outputs\fa_models_table2.rtf", ///
     cells("L[Factor1](t fmt(2)) L[Factor2](t) r_L[Factor1](t) r_L[Factor2](t) Psi[Uniqueness]") ///
     mgroups("Unrotated" "Rotated", pattern(1 0 1 0 0) ) ///
		coeflabels(	english_sc 	"English Points Score" ///
					maths_sc 	"Maths Points Score" ///
					science_sc	"Science Points Score" ///
					humanity_sc	"Humanity Points Score" ///
					othersub_sc "Other Subject Points Score" ) ///
	 nogap noobs nonumber replace
	 
* Put labels on the score variables and a note

* Graph is available if desired

* loadingplot, aspect(1)
* graph save $path2\temp\ycs5_11_factors.pdf, replace

***

* Regression models of scores - this is from the unrotated solution

* Factor 1 (f1 is general ability)

regress f1 		i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight]
est store g

* Factor 2 (f2 is English/Humanities ability)

regress f2 		i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=t1weight]
est store h

* Use esttab to export results

numlabel _all, rem

esttab g h using "$path2\outputs\fa_models_table3.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) r2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("Factor 1 Score" "Factor 2 Score") ///
	wide staraux nogaps noparentheses replace

clear

* END *
