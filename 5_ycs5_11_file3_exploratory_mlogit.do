* 10th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Investigation of multinomial logistic regression models

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

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

tab sample3_modal_class, mi
tab sample3_modal_class

* Apply the weighting.

svyset [pw=t1weight]
svydescribe

* Descriptive Statistics for Latent Classes

mean t0score, over(sample3_modal_class)

* Latent Class Membership by background measures

tab t0cohort 		sample3_modal_class, row nofreq
tab t0sex 			sample3_modal_class, row nofreq
tab t0ethnic 		sample3_modal_class, row nofreq
tab t0house 		sample3_modal_class, row nofreq
tab t0stay 			sample3_modal_class, row nofreq
tab t0par_nssec2 	sample3_modal_class, row nofreq

***

* Initial Model

svy: mlogit sample3_modal_class ///
				i.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2, base(4)
				
* Pretty much what I would expect.

* Now include the year

svy: mlogit sample3_modal_class ///
				i.t0cohort ///
				i.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2, base(4)

***

* Compare middle attainment groups

svy: mlogit sample3_modal_class ///
				i.t0cohort ///
				i.t0sex ///
				i.t0ethnic ///
				i.t0house ///
				i.t0stay ///
				ib2.t0par_nssec2, base(3)

* Less of a clear picture.
				
clear

* END *
