* 12th February 2019

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Sensitivity analysis YCS5-YCS11: Full SEM model compared to three-step approaches using LCA

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
 global path3 "C:\temp\github_ycs_subject_analysis\data\"
*global path3 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\data\"
 global path4 "U:\work\Research\UKHLS_NPD_Latent_Class_Analysis\github_ycs_subject_analysis\raw_data\YCS_time_series\stata8\"

clear
set more off

***

* Load dataset

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* codebook, compact

keep if sample3==1
count

* Stata 15.1 now has Latent Class Analysis built in to gsem
* See https://www.stata.com/new-in-stata/latent-class-analysis/

* Standard Regression model

reg t0score2 	i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2

* Is almost the same as...
				
gsem (t0score2 <-	i.t0cohort ///
				ib2.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2)

***
				
* Test weighting using svy

svy: reg t0score2 	i.t0cohort ///
					ib2.t0sex ///
					i.t0ethnic ///
					i.t0house ///
					i.t0stay ///
					ib2.t0par_nssec2
					
svy: gsem (t0score2 <-	i.t0cohort ///
						ib2.t0sex ///
						i.t0ethnic ///
						i.t0house ///
						i.t0stay ///
						ib2.t0par_nssec2)

* Yes, these are the same
						
***

* Test the SEM using a subset of the data

tab t0cohort, mi

keep if t0cohort==1990
count

* 7736 cases

tab t0sex, mi		/* I wonder if it doesn't like the i notation */

tab t0sex, gen(sex)
tab1 sex1 sex2, mi

* Example of an mlogit (using the modal assignment)

gsem (i.sample3_modal_class <- i.t0sex), mlogit

***

* https://www.stata.com/meeting/nordic-and-baltic17/slides/nordic-and-baltic17_Pitblado.pdf
* https://www.stata.com/meeting/uk18/slides/uk18_MacDonald.pdf
* https://www.stata.com/manuals/semintro2.pdf#semintro2 (see page 30)

* THIS ONE 3pm 13th February 2019
* https://www.statalist.org/forums/forum/general-stata-discussion/general/1427610-gsem-lclass-option-trying-to-predict-class-membership-from-an-auxiliary-variable

* https://www.statalist.org/forums/forum/general-stata-discussion/general/1397167-latent-class-analysis-with-stata-15-gsem-problem

***

* These are specified as 1 and 2. Dummy code for gsem

tab1 english maths science humanity othersub, mi
recode english maths science humanity othersub (1 = 0) (2 = 1)
tab1 english maths science humanity othersub, mi

* Repeat the model

gsem (english maths science humanity othersub <-), logit lclass(C 4)

estat lcprob
estat lcmean

* This is the correct way to specify the model - simple version just with sex variable

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- i.t0sex), lclass(C 4)
	 
estat lcprob
estat lcmean

* The full model worked for one cohort (1990) without base option specified

* See https://www.stata.com/manuals13/semintro12.pdf

***

* Trying the full model

* Load dataset

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* These are specified as 1 and 2. Dummy code for gsem

tab1 english maths science humanity othersub, mi
recode english maths science humanity othersub (1 = 0) (2 = 1)
tab1 english maths science humanity othersub, mi

* Need to exclude Bangladeshi children because of small subsample size

tab t0ethnic, mi
drop if t0ethnic==7

* Simple model first l layer up

/*
gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	ib2.t0sex), lclass(C 4, base(4) )

matrix mod1 = e(b)

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	ib2.t0par_nssec2), lclass(C 4, base(4) ) from (mod1)
	 
matrix mod2 = e(b)
*/

* Model 1 - Order of latent classes is random
 
* Model on full data to get parameters
* Excludes Bangladeshi children
* GSEM uses all available cases

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	i.t0cohort ///
			ib2.t0sex ///
			i.t0ethnic ///
			i.t0house ///
			i.t0stay ///
			ib2.t0par_nssec2), lclass(C 4, base(4) )

matrix mod3 = e(b)

estat lcprob
estat lcmean, nose		/* Too slow without this option... */


* Model 2 - Re-estimate model 1 with base category 3 (highest attainment group)

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	i.t0cohort ///
			ib2.t0sex ///
			i.t0ethnic ///
			i.t0house ///
			i.t0stay ///
			ib2.t0par_nssec2), lclass(C 4, base(3) )

* Forgot to save matrix of estimates

estat lcprob, nose
estat lcmean, nose

*** Svy weighting may make this quite complex. Let's try on sample 3 first

***

* Model 3 - Estimated on same sample as three-step LCA approach (excluding Bangladeshi children)

keep if sample3==1
count

* Core sample

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	i.t0cohort ///
			ib2.t0sex ///
			i.t0ethnic ///
			i.t0house ///
			i.t0stay ///
			ib2.t0par_nssec2), lclass(C 4, base(3) )
			
estat lcprob, nose
estat lcmean, nose

* In future I should save the model estimates for running the next model

***

* Model 4 - Re-estimate model 3 with base category 3 (highest attainment group)

* This is the unweighted model

gsem (english maths science humanity othersub <- , logit) ///
	 (C <- 	i.t0cohort ///
			ib2.t0sex ///
			i.t0ethnic ///
			i.t0house ///
			i.t0stay ///
			ib2.t0par_nssec2), lclass(C 4, base(3) ) from(mod3, skip)
			
matrix mod4 = e(b)		/* Saved parameter estimates */
			
estat lcprob, nose
estat lcmean, nose

estat lcprob
estat lcmean

***

* Model 5 - Re-estimate model 4 using svy weighting to account for patterns of non-response

* Now repeat with weighting and use the starting values from the model above

svy: gsem (english maths science humanity othersub <- , logit) ///
	      (C <- 	i.t0cohort ///
					ib2.t0sex ///
					i.t0ethnic ///
					i.t0house ///
					i.t0stay ///
					ib2.t0par_nssec2), lclass(C 4, base(3) ) from(mod4, skip)
			
matrix mod5 = e(b)		/* Saved parameter estimates for weighted model */
			
estat lcprob, nose
estat lcmean, nose

* Now run with full version of lcprob and lcmean

estat lcprob
estat lcmean

estat lcprob, classposteriorpr	/* Posterior probabilities */

* Goodness of fit measures (estat lcgof didn't work with svy)

* Re-run model 5 using weight option rather than svy for model output

gsem (english maths science humanity othersub <- , logit) ///
     (C <- 	i.t0cohort ///
			ib2.t0sex ///
			i.t0ethnic ///
			i.t0house ///
			i.t0stay ///
			ib2.t0par_nssec2) [pw=t1weight], ///
					lclass(C 4, base(3) ) from(mod5, skip)

estat lcgof

ereturn list
					
estat lcprob, nose
estat lcmean, nose

* Need to save out matrix mod5 with parameter estimates

matrix list mod5

putexcel set "C:\temp\github_ycs_subject_analysis\temp\GSEM\gsem_lca_mod5.xlsx"
putexcel A1=matrix(mod5), names

* import excel using "C:\temp\github_ycs_subject_analysis\temp\GSEM\gsem_lca_mod5.xlsx"
* The column names is causing some confusion
* Requires further investigation if I wish to reuse this

* Stop analysis 1900 19/2/2019

clear


***

* This has not been run

* Model 6 - Repeat model 5 using full data and svy weights

* Reload data
/*
use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

* These are specified as 1 and 2. Dummy code for gsem

tab1 english maths science humanity othersub, mi
recode english maths science humanity othersub (1 = 0) (2 = 1)
tab1 english maths science humanity othersub, mi

* Need to exclude Bangladeshi children because of small subsample size

tab t0ethnic, mi
drop if t0ethnic==7
*/

/*
svy: gsem (english maths science humanity othersub <- , logit) ///
		  (C <- 	i.t0cohort ///
					ib2.t0sex ///
					i.t0ethnic ///
					i.t0house ///
					i.t0stay ///
					ib2.t0par_nssec2), lclass(C 4, base(3) )

estat lcprob, nose
estat lcmean, nose

estat lcprob
estat lcmean
*/

* END *
