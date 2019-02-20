* 6th February 2019

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Sensitivity analysis YCS5-YCS11: Proportional assignment and Factor Analysis

* Different file paths - Exeter

 global path5 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_5_Download\stata8\"
 global path6 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_6_Download\stata8\"
 global path7 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_7_Download\stata8\"
 global path8 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_8_Download\stata8\"
 global path9 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_9_Download\stata8\"
global path10 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_10_Download\stata8_se\"
global path11 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_11_Download\stata8_se\"
global path12 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_12_Download\stata8\"
global path13 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_Cohort_13_Download\stata9\"

 global path2 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\"
 global path3 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\data\"
 global path4 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_time_series\stata8\"

clear
set more off

***

* Load dataset

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

codebook, compact

* Stata 15.1 now has Latent Class Analysis built in to gsem
* See https://www.stata.com/new-in-stata/latent-class-analysis/

* Let's compare the estimates from gsem with the doLCA package

tab sample3_modal_class, mi

keep if sample3==1
count

* These are specified as 1 and 2. Dummy code for gsem

tab1 english maths science humanity othersub, mi
recode english maths science humanity othersub (1 = 0) (2 = 1)
tab1 english maths science humanity othersub, mi

* Estimate latent class model (4 classes) using gsem

gsem (english maths science humanity othersub <-), logit lclass(C 4)

* This is very slow compared to doLCA package

estat lcprob
estat lcmean

* The estimates are identical to the doLCA package

* Other information retained in the model

return list
ereturn list

* Goodness of fit measures

estat lcgof

***

* Predicting latent class probabilities

* These have already been appended to the dataset in the variables:
* sample3_pp1 sample3_pp2 sample3_pp3 sample3_pp4

***

* Estimating posterior probability weighted mlogit

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

tab sample3_modal_class, mi

keep if sample3==1
count

* Need to reshape the data into long format by posterior probability weights

rename sample3_pp1 pp1
rename sample3_pp2 pp2
rename sample3_pp3 pp3
rename sample3_pp4 pp4

* Create id variable for case number

gen id = _n
codebook id

* Reshape long so that that each individual is represented 4 times 
* with posterior probability weight

reshape long pp, i(id) j(class)

list id t0sex pp class in 1/17
count

* Fit multinomial logistic regression model using posterior probability weight

* Combine the posterior probability weight with the survey weight

codebook pp t1weight
gen lca_weight = pp * t1weight

svyset [pw=lca_weight]
svydescribe

tab sample3_modal_class

* Estimating the multinomial logistic regression model

xi: svy: mlogit class ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					, base(4)

* Equivalent command not using svy (for post-estimation reporting)
					
xi: mlogit class ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2 ///
					[pw=lca_weight], base(4)
est store a					

* Write out results as table 10

esttab a using "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\outputs\table10.rtf", ///
	b(%9.2f) se(%9.2f) aic(%9.1f) bic(%9.1f) scalars("ll Log lik.") sfmt(%9.1f) pr2 ///
	starlevels(* .10 ** .05 *** .01) stardetach 	///
	label mtitles("Multnomial Logit") ///
	wide staraux nogaps noparentheses replace

***

capture log close
capture log using $path2\temp\ycs5_11_factor_analysis.txt, replace text

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* Fit factor analysis

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

* Check variables on analytic sample

keep if sample3==1
count

tab1 english_sc maths_sc science_sc humanity_sc othersub_sc, mi

* Fit factor analysis and rotate

factor english_sc maths_sc science_sc humanity_sc othersub_sc, pcf

factor english_sc maths_sc science_sc humanity_sc othersub_sc

rotate

* Iterated Principal Factors

factor english_sc maths_sc science_sc humanity_sc othersub_sc, ipf factors(2)

scoreplot

* ML Factor Analysis

estimates clear

factor english_sc maths_sc science_sc humanity_sc othersub_sc, ml

estat factors
estat structure

loadingplot, aspect(1)
graph save $path2\temp\ycs5_11_factors.pdf, replace

* scoreplot

predict f1 f2


* rotate, varimax

* Factor 1 (f1 is general ability)

svy: regress f1 ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2

* Factor 2 (f2 is English/Humanities ability)

svy: regress f2 ///
				i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2
				
log close
clear

* END *


