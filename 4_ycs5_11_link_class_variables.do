* 9th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Linking NS-SEC information from CAMSIS website

* SOC90 	- http://www.camsis.stir.ac.uk/downloads/data/gb91soc90.dta
* SOC2000 	- http://www.camsis.stir.ac.uk/downloads/data/gb91soc2000.dta

* See		- http://www.cardiff.ac.uk/socsi/CAMSIS/occunits/distribution.html#UK

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

* YCS 5-11 Dataset

use $path3\ycs5_to_11_set2.dta, clear
numlabel _all, add

* SOC90 variables

mvdecode t0dadsoc t0mumsoc, mv(-9)
codebook t0dadsoc t0mumsoc

* SOC2000 variables

codebook t0dadsoc2000 t0mumsoc2000

* Self-employment indicators

tab1 t0dadse t0mumse, mi

***

* SOC90/SOC2000 Create self-employment indicators (reduced method)
* Read 'gb91soc90.readme'
* Read 'gb91soc2000.readme'

gen t0dad_empst = 7					/* Employment Status = 7 Employee */
replace t0dad_empst=2 if t0dadse==1	/* Employment Status = 2 Self-empl with fewer than 25 employees */
label variable t0dad_empst "Father's Employment Status"
tab t0dad_empst

gen t0mum_empst = 7					/* Employment Status = 7 Employee */
replace t0mum_empst=2 if t0mumse==1	/* Employment Status = 2 Self-empl with fewer than 25 employees */
label variable t0mum_empst "Mother's Employment Status"
tab t0mum_empst

***

* Merge Father's SOC90 - YCS5-YCS9.
* http://www.camsis.stir.ac.uk/downloads/data/gb91soc90.dta

* Rename variables pre-merge

rename t0dad_empst ukempst
rename t0dadsoc soc90

merge m:1 soc90 ukempst using ///
	"http://www.camsis.stir.ac.uk/downloads/data/gb91soc90.dta", ///
	keepusing(mcamsis fcamsis rgsc rns_sec)

drop if _merge==2					/* Keep only records in master dataset */
tab _merge
drop _merge

***

* Rename variables post-merge

rename ukempst 	t0dad_empst
rename soc90 	t0dadsoc 
rename mcamsis 	t0dad_mcamsis
rename fcamsis 	t0dad_fcamsis
rename rgsc		t0dad_rgsc
rename rns_sec	t0dad_nssec

* Inspection - comparing number of missing cases

tab t0cohort if t0cohort<1999
codebook t0dadsoc if t0cohort<1999

tab1 t0dad_rgsc t0dad_nssec, mi

* Recoding information for Father's RGSC (from Paul Lambert originally)

capture drop t0dad_rgsc2
gen t0dad_rgsc2=t0dad_rgsc
replace t0dad_rgsc2=1 if 	t0dadsoc==100 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc>100 & t0dadsoc<232 & t0dad_rgsc==0
replace t0dad_rgsc2=1 if 	t0dadsoc==232 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc>232 & t0dadsoc<396 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc==400 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc==401 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc==460 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc==462 & t0dad_rgsc==0
replace t0dad_rgsc2=3.1 if 	t0dadsoc==463 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=523 & t0dadsoc<=582 & t0dad_rgsc==0
replace t0dad_rgsc2=3.1 if 	t0dadsoc==600 & t0dad_rgsc==0
replace t0dad_rgsc2=. if 	t0dadsoc==601 & t0dad_rgsc==0
replace t0dad_rgsc2=3.1 if 	t0dadsoc>=610 & t0dadsoc<=612 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc>=621 & t0dadsoc<=622 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=630 & t0dadsoc<=642 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc>=644 & t0dadsoc<=659 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=660 & t0dadsoc<=671 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc==672 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=690 & t0dadsoc<=691 & t0dad_rgsc==0
replace t0dad_rgsc2=2 if 	t0dadsoc>=700 & t0dadsoc<=703 & t0dad_rgsc==0
replace t0dad_rgsc2=3.1 if 	t0dadsoc>=720 & t0dadsoc<=790 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=802 & t0dadsoc<=823 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc>=844 & t0dadsoc<=863 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=870 & t0dadsoc<=871 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc==875 & t0dad_rgsc==0
replace t0dad_rgsc2=3.2 if 	t0dadsoc>=881 & t0dadsoc<=887 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc>=893 & t0dadsoc<=910 & t0dad_rgsc==0
replace t0dad_rgsc2=5 if 	t0dadsoc>=911 & t0dadsoc<=912 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc==913 & t0dad_rgsc==0
replace t0dad_rgsc2=5 if 	t0dadsoc>=919 & t0dadsoc<=933 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc==940 & t0dad_rgsc==0
replace t0dad_rgsc2=5 if 	t0dadsoc==941 & t0dad_rgsc==0
replace t0dad_rgsc2=4 if 	t0dadsoc>=952 & t0dadsoc<=954 & t0dad_rgsc==0
replace t0dad_rgsc2=5 if 	t0dadsoc==955 & t0dad_rgsc==0

tab1 t0dad_rgsc t0dad_rgsc2, mi

* Rename and replace the RGSC variable with category 0.

drop t0dad_rgsc
rename t0dad_rgsc2 t0dad_rgsc
label variable t0dad_rgsc "Registrar-General's Social Class"

***

* Merge Mother's SOC90 - YCS5-YCS9.
* http://www.camsis.stir.ac.uk/downloads/data/gb91soc90.dta

* Rename variables pre-merge

rename t0mum_empst ukempst
rename t0mumsoc soc90

merge m:1 soc90 ukempst using ///
	"http://www.camsis.stir.ac.uk/downloads/data/gb91soc90.dta", ///
	keepusing(mcamsis fcamsis rgsc rns_sec)

drop if _merge==2					/* Keep only records in master dataset */
tab _merge
drop _merge

***

* Rename variables post-merge

rename ukempst 	t0mum_empst
rename soc90 	t0mumsoc 
rename mcamsis 	t0mum_mcamsis
rename fcamsis 	t0mum_fcamsis
rename rgsc		t0mum_rgsc
rename rns_sec	t0mum_nssec

* Inspection - comparing number of missing cases

tab t0cohort if t0cohort<1999
codebook t0mumsoc if t0cohort<1999

tab1 t0mum_rgsc t0mum_nssec, mi

* Recoding information for Mother's RGSC (from Paul Lambert originally)

capture drop t0mum_rgsc2
gen t0mum_rgsc2=t0mum_rgsc
replace t0mum_rgsc2=1 if 	t0mumsoc==100 & t0mum_rgsc==0
replace t0mum_rgsc2=2 if 	t0mumsoc>=101 & t0mumsoc<=173 & t0mum_rgsc==0
replace t0mum_rgsc2=3.1 if 	t0mumsoc==174 & t0mum_rgsc==0
replace t0mum_rgsc2=2 if 	t0mumsoc>=175 & t0mumsoc<=199 & t0mum_rgsc==0
replace t0mum_rgsc2=2 if 	t0mumsoc>=270 & t0mumsoc<=390 & t0mum_rgsc==0
*not an error *
replace t0mum_rgsc2=2 if 	t0mumsoc>=400 & t0mumsoc<=460 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==462 & t0mum_rgsc==0
replace t0mum_rgsc2=3.1 if 	t0mumsoc==491 & t0mum_rgsc==0
replace t0mum_rgsc2=3.2 if 	t0mumsoc==581 & t0mum_rgsc==0
replace t0mum_rgsc2=. if 	t0mumsoc==600 & t0mum_rgsc==0
replace t0mum_rgsc2=3.1 if 	t0mumsoc==610 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==621 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==622 & t0mum_rgsc==0
replace t0mum_rgsc2=3.2 if 	t0mumsoc==630 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc>=644 & t0mumsoc<=659 & t0mum_rgsc==0
replace t0mum_rgsc2=3.2 if 	t0mumsoc>=660 & t0mumsoc<=691 & t0mum_rgsc==0
replace t0mum_rgsc2=2 if 	t0mumsoc==702 & t0mum_rgsc==0
replace t0mum_rgsc2=3.1 if 	t0mumsoc>=720 & t0mumsoc<=792 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==851 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==859 & t0mum_rgsc==0
replace t0mum_rgsc2=3.2 if 	t0mumsoc>=861 & t0mumsoc<=871 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==913 & t0mum_rgsc==0
replace t0mum_rgsc2=5 if 	t0mumsoc==919 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc==940 & t0mum_rgsc==0
replace t0mum_rgsc2=5 if 	t0mumsoc==941 & t0mum_rgsc==0
replace t0mum_rgsc2=4 if 	t0mumsoc>=952 & t0mumsoc<=954 & t0mum_rgsc==0
replace t0mum_rgsc2=5 if 	t0mumsoc==955 & t0mum_rgsc==0

tab1 t0mum_rgsc t0mum_rgsc2, mi

* Rename and replace the RGSC variable with category 0.

drop t0mum_rgsc
rename t0mum_rgsc2 t0mum_rgsc
label variable t0mum_rgsc "Registrar-General's Social Class"

***

* Merge Father's SOC2000 - YCS10-YCS11.
* http://www.camsis.stir.ac.uk/downloads/data/gb91soc2000.dta

* Rename variables pre-merge

rename t0dad_empst ukempst
rename t0dadsoc2000 soc2000

merge m:1 soc2000 ukempst using ///
	"http://www.camsis.stir.ac.uk/downloads/data/gb91soc2000.dta", ///
	keepusing(mcamsis fcamsis rgsc rns_sec)

drop if _merge==2					/* Keep only records in master dataset */
tab _merge
drop _merge

***

* Rename variables post-merge

rename ukempst 	t0dad_empst
rename soc2000	t0dadsoc2000 

* Inspect variables for missing cases by YCS cohort

tab t0dad_rgsc if t0cohort<1999, mi		/* Based on SOC90 */
tab t0dad_rgsc if t0cohort>1997, mi		/* All missing because no SOC90 after YCS10 */

codebook t0dadsoc2000 if t0cohort<1999	/* All missing because no SOC2000 before YCS10 */
codebook t0dadsoc2000 if t0cohort>1997	/* Based on SOC2000 */

tab rns_sec if t0cohort<1999, mi		/* All missing because no SOC2000 before YCS10 */
tab rns_sec if t0cohort>1997, mi		/* Based on SOC2000 */

* Replace values for YCS10 & YCS11 & Inspect

codebook t0dad_mcamsis
replace t0dad_mcamsis = mcamsis if t0cohort>1997
codebook t0dad_mcamsis

codebook t0dad_fcamsis
replace t0dad_fcamsis = fcamsis if t0cohort>1997
codebook t0dad_fcamsis

tab t0dad_rgsc, mi
replace t0dad_rgsc = rgsc if t0cohort>1997
tab t0dad_rgsc, mi

tab t0dad_nssec, mi
replace t0dad_nssec = rns_sec if t0cohort>1997
tab t0dad_nssec, mi

* Drop variables which are no longer required

drop mcamsis fcamsis rns_sec rgsc

***

* Merge Mother's SOC2000 - YCS10-YCS11.
* http://www.camsis.stir.ac.uk/downloads/data/gb91soc2000.dta

* Rename variables pre-merge

rename t0mum_empst ukempst
rename t0mumsoc2000 soc2000

merge m:1 soc2000 ukempst using ///
	"http://www.camsis.stir.ac.uk/downloads/data/gb91soc2000.dta", ///
	keepusing(mcamsis fcamsis rgsc rns_sec)

drop if _merge==2					/* Keep only records in master dataset */
tab _merge
drop _merge

***

* Rename variables post-merge

rename ukempst 	t0mum_empst
rename soc2000	t0mumsoc2000 

* Inspect variables for missing cases by YCS cohort

tab t0mum_rgsc if t0cohort<1999, mi		/* Based on SOC90 */
tab t0mum_rgsc if t0cohort>1997, mi		/* All missing because no SOC90 after YCS10 */

codebook t0mumsoc2000 if t0cohort<1999	/* All missing because no SOC2000 before YCS10 */
codebook t0mumsoc2000 if t0cohort>1997	/* Based on SOC2000 */

tab rns_sec if t0cohort<1999, mi		/* All missing because no SOC2000 before YCS10 */
tab rns_sec if t0cohort>1997, mi		/* Based on SOC2000 */

* Replace values for YCS10 & YCS11 & Inspect

codebook t0mum_mcamsis
replace t0mum_mcamsis = mcamsis if t0cohort>1997
codebook t0mum_mcamsis

codebook t0mum_fcamsis
replace t0mum_fcamsis = fcamsis if t0cohort>1997
codebook t0mum_fcamsis

tab t0mum_rgsc, mi
replace t0mum_rgsc = rgsc if t0cohort>1997
tab t0mum_rgsc, mi

tab t0mum_nssec, mi
replace t0mum_nssec = rns_sec if t0cohort>1997
tab t0mum_nssec, mi

* Drop variables which are no longer required

drop mcamsis fcamsis rns_sec rgsc

***

* Relabel variables for clarity

label variable t0dad_mcamsis 	"Father's Male CAMSIS score"
label variable t0dad_fcamsis 	"Father's Female CAMSIS score"
label variable t0mum_mcamsis 	"Mother's Male CAMSIS score"
label variable t0mum_fcamsis 	"Mother's Female CAMSIS score"
label variable t0dad_nssec 		"Father's National Statistics Socio-Economic Classification (Reduced Form)"
label variable t0dad_rgsc 		"Father's Registrar-General's Social Class"
label variable t0mum_nssec 		"Mother's National Statistics Socio-Economic Classification (Reduced Form)"
label variable t0mum_rgsc 		"Mother's Registrar-General's Social Class"

* Change order of variables

order	t0dad_empst ///
		t0mum_empst ///
		t0dad_mcamsis ///
		t0dad_fcamsis ///
		t0dad_nssec ///
		t0dad_rgsc ///
		t0mum_mcamsis ///
		t0mum_fcamsis ///
		t0mum_nssec ///
		t0mum_rgsc, ///
			after(t0mumsoc2000)

***			
			
* Tangential investigation of YCS11 class variables supplied with SN5452

tab ycs11_t0dad_nssec t0dad_nssec if t0cohort==2001, mi
corr ycs11_t0dad_nssec t0dad_nssec

* Correlation of 0.96 - pretty good.

tab ycs11_t0mum_nssec t0mum_nssec if t0cohort==2001, mi
corr ycs11_t0mum_nssec t0mum_nssec

* Correlation of 0.97 - pretty good.

* I am going to drop the YCS11 variables to avoid confusion

drop ycs11_t0dad_nssec ycs11_t0mum_nssec

***

* Save dataset

save $path3\ycs5_to_11_set3.dta, replace
codebook, compact
			
clear

* END *
