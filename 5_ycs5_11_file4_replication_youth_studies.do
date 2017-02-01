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

* Apply the weighting.

svyset [pw=t1weight]
svydescribe

* Table 1. Agglomerate measures of GCSE attainment

svy: tab t03cat if sample3==1

svy: tab t03cat_em if sample3==1

svy: mean t0score if sample3==1		/* This is not capped at 84 points */ 
svy: mean t0examst if sample3==1

svy: mean t0examac if sample3==1
svy: mean t0examaf if sample3==1

* Break this down by YCS cohort

***

clear

* END *
