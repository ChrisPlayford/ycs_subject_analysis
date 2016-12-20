* 20th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS10 Comparison of Harmonised Variables with SN5765.

* This is a manual work-around because of the lack of the 'serial' id variable in YCS10.

***

* The location of the folder containing the YCS wave 10 data

 global path5 "A:\data\YCS_Cohort_5_Download\stata8\"
 global path6 "A:\data\YCS_Cohort_6_Download\stata8\"
 global path7 "A:\data\YCS_Cohort_7_Download\stata8\"
 global path8 "A:\data\YCS_Cohort_8_Download\stata8\"
 global path9 "A:\data\YCS_Cohort_9_Download\stata8\"
* global path10 "A:\data\YCS_Cohort_10_Download\stata8_se\"
global path11 "A:\data\YCS_Cohort_11_Download\stata8_se\"
global path12 "A:\data\YCS_Cohort_12_Download\stata8\"
global path13 "A:\data\YCS_Cohort_13_Download\stata9\"

 global path3 "A:\YCS\github_ycs_subject_analysis\data\"
 global path4 "A:\data\YCS_time_series\stata8\"

* Moved file to temporary location because network connection too slow
global path10 "C:\Users\cplayfor\Documents\temp\"

clear
set more off

use $path3\ycs10_background_vars.dta, clear
numlabel _all, add

***

* For each of the variables I will check to see whether they are identical in the two datasets
* If this is the case, then I have checked my code for errors and do not require ew_core for YCS10
* This has the advantage of 'getting around' the lack of a serial number.

* 1) t0cohort

tab t0cohort, mi

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
tab t0cohort, mi
restore

* 2) t0nation

tab t0nation, mi

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
tab t0nation, mi
restore

* 3) t0caseid - This is missing from SN4571

codebook t0caseid

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
codebook t0caseid
restore

* Obviously, given the problem, these are different.

* 4) t0source = ycs10

tab t0source, mi

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
tab t0source, mi
restore

*** WEIGHTINGS.

* 5) t1weight=sweep1
* 6) There is no t2weight in YCS10 */
* 7) t3weight=s3basic

codebook t1weight t3weight, compact

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
codebook t1weight t3weight, compact
restore

* 8-10 Ignore t1resp - t3resp - not present.

* 11) t0schtyp=s1estab

tab t0schtyp, mi

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
tab t0schtyp, mi
restore

* These differ but I don't understand why. My coding makes sense.

* 12) t0sex=s1sex

tab t0sex, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
tab t0sex, missing
restore

* 13) t0stay=s1live

tab t0stay, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0stay, add
tab t0stay, missing
restore

* Pretty close.

* 14) t0sibs = going to leave this one.

* 15) t0ethnic = a58

tab t0ethnic, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0ethnic, add
tab t0ethnic, missing
restore

* Pretty close.

* 16) t0house = s1house

tab t0house, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0house, add
tab t0house, missing
restore

* Pretty close.

* 17) t0dadpce=a57fg

tab t0dadpce, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0dadpce, add
tab t0dadpce, missing
restore

* 18) t0mumpce=a57mg

tab t0mumpce, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0mumpce, add
tab t0mumpce, missing
restore

* 19) t0dadalv=a57fg

tab t0dadalv, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0dadalv, add
tab t0dadalv, missing
restore

* 20) t0mumalv=a57mg

tab t0mumalv, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0mumalv, add
tab t0mumalv, missing
restore

* 21) t0daddeg=a57fh

tab t0daddeg, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0daddeg, add
tab t0daddeg, missing
restore

* 22) t0mumdeg=a57mh

tab t0mumdeg, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0mumdeg, add
tab t0mumdeg, missing
restore

*  23) t0dadjob=a57fa

tab t0dadjob, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0dadjob, add
tab t0dadjob, missing
restore

* 24) t0mumjob=a57ma

tab t0mumjob, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0mumjob, add
tab t0mumjob, missing
restore

* 25) t0truant=a61

tab t0truant, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0truant, add
tab t0truant, missing
restore

* 26) t1att1=a1_1

tab t1att1, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t1att1, add
tab t1att1, missing
restore

* 27) t1att2=a1_2

tab t1att2, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t1att2, add
tab t1att2, missing
restore

* 28) t1att3=a1_3

tab t1att3, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t1att3, add
tab t1att3, missing
restore

* 29) t0region=sw1v9

tab t0region, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0region, add
tab t0region, missing
restore

* Some differences but unlikely to use in analysis.

* 30) t0dadsoc=ns1socf
* 31) t0mumsoc=ns1socm

codebook t0dadsoc t0mumsoc, compact

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
codebook t0dadsoc t0mumsoc, compact
restore

* THESE ARE DIFFERENT...

* 32 - 39 are qualifications.

* Skipping 40 - 42 (Not used in analysis)

* 43) t0dadse=a57fe

tab t0dadse, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0dadse, add
tab t0dadse, missing
restore

** 44) t0mumse=a57me

tab t0mumse, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0mumse, add
tab t0mumse, missing
restore

* 45) t0gor (very similar to t0region)

tab t0gor, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0gor, add
tab t0gor, missing
restore

* NEED TO REVISIT THIS...

* Skipping 46 - 48 (not used in analysis)

* 49) t0parsec

tab t0parsec, missing

preserve
use $path4\ew_core.dta, clear
keep if t0cohort==1999
numlabel t0parsec, add
tab t0parsec, missing
restore

* THESE ARE COMPLETELY DIFFERENT... NOT THE SAME VARIABLE CONSTRUCTION.

* Skipping 50 - 66 (not used in analysis)

