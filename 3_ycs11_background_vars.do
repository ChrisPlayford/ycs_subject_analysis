* 20th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS11 Preparation of respondent background information

* The location of the folder containing the YCS wave 10 data

 global path5 "A:\data\YCS_Cohort_5_Download\stata8\"
 global path6 "A:\data\YCS_Cohort_6_Download\stata8\"
 global path7 "A:\data\YCS_Cohort_7_Download\stata8\"
 global path8 "A:\data\YCS_Cohort_8_Download\stata8\"
 global path9 "A:\data\YCS_Cohort_9_Download\stata8\"
global path10 "A:\data\YCS_Cohort_10_Download\stata8_se\"
* global path11 "A:\data\YCS_Cohort_11_Download\stata8_se\"
global path12 "A:\data\YCS_Cohort_12_Download\stata8\"
global path13 "A:\data\YCS_Cohort_13_Download\stata9\"

 global path3 "A:\YCS\github_ycs_subject_analysis\data\"
 global path4 "A:\data\YCS_time_series\stata8\"

* Moved file to temporary location because network connection too slow
global path11 "C:\Users\cplayfor\Documents\temp\"

clear
set more off

use $path11\ycs_c11s1234.dta, clear
* numlabel _all, add

* YCS11 Data Dictionary
* A:\data\YCS_Cohort_11_Download\mrdoc\allissue\ycs_c11s1234_ukda_data_dictionary.docx

* YCS11 User Guide
* A:\data\YCS_Cohort_11_Download\mrdoc\pdf\5452userguide.pdf

***

* RECODING WORK

* 1) t0cohort

gen t0cohort=2001
label variable t0cohort "year completed compulsory schooling"
tab t0cohort

* 2) t0nation

gen t0nation=s1gor
tab t0nation
recode t0nation 1/10=1 11=2
label define t0nation1 1 "England" 2 "Wales"
label values t0nation t0nation1
label variable t0nation "national system"
tab t0nation

* 3) t0caseid 

codebook sn
gen t0caseid = sn
label variable t0caseid "id for time series"
codebook t0caseid

* 4) t0source = ycs11

gen t0source = "ycs11"
label variable t0source "source of data"
tab t0source

* WEIGHTINGS.

* 5) t1weight=s1weight
gen t1weight=s1weight
label variable t1weight "weight s1"

* 6) t2weight=s2weight
gen t2weight=s2weight
label variable t2weight "weight s2"

* 7) t3weight=s3weight
gen t3weight=s3weight
label variable t3weight "weight s3"

codebook t1weight t2weight t3weight

* 8 - 10 Not sure what has happened to t1resp - t3resp
* tab1 s1resp s2resp s3resp, mi
* These don't appear to be there...

* 11) t0schtyp=s1estab

tab s1estab, missing
tab s1estab, nolabel missing

gen t0schtyp=s1estab
recode t0schtyp (1 8=2) (2 9=3) (3=4) (5=5) (4 10=7) (6 7=8)  
tab s1estab t0schtyp, missing

label define t0schtyp1 ///
1 "6th form college" ///
2 "comp to 16" ///
3 "comp to 18" ///
4 "grammar" ///
5 "sec modern" ///
6 "other state funded" ///
7 "independent" ///
8 "ctc"

label values t0schtyp t0schtyp1
label variable t0schtyp "school type"
tab t0schtyp, missing

tab t0schtyp s1estab, missing

* 12) t0sex=s1sex

tab s1sex, missing
describe s1sex
gen t0sex=s1sex
label variable t0sex "gender"
label values t0sex s1sex
tab t0sex, missing

* 13) t0stay=s1live

tab s1live, missing
tab s1live, missing nolabel

gen t0stay = s1live
mvdecode t0stay, mv(-9)
recode t0stay 4=1 2=2 1=3 3=4

tab t0stay, missing
tab s1live t0stay, missing 

label define t0stay1 ///
1 "father and mother" ///
2 "mother only" ///
3 "father only" ///
4 "other response"

label values t0stay t0stay1
label variable t0stay "household at t1"

tab t0stay, missing
tab t0stay s1live, missing

* 14) t0sibs = Number of brothers and sisters

* tab1 s1q74c, missing
* I don't think this is measured

* 15) t0ethnic = s1eth2

tab1 s1eth1 s1eth2, missing
tab s1eth2, missing nolabel

gen t0ethnic = s1eth2
mvdecode t0ethnic, mv(-9)
recode t0ethnic 1=1 2/5=4 7=5 8=6 9=7 10/11=9 12/13=10
label variable t0ethnic "ethnic classification"

label define t0ethnic1 ///
-9 "not answered" ///
1 "white" ///
4 "black" ///
5 "indian" ///
6 "pakistani" ///
7 "bangladeshi" ///
9 "other asian" ///
10 "other response"
label values t0ethnic t0ethnic1

tab t0ethnic, missing
tab t0ethnic s1eth2, missing

* 16) t0house = s1house

tab s1house, missing

gen t0house=s1house
recode t0house 1=1 2/3=2 4=3 5=-9
label define t0house1 -9 "not answered" 1 "owned" 2 "rented" 3 "other"
label values t0house t0house1
numlabel t0house1, add
label variable t0house "parents housing type" 
tab t0house, missing
tab t0house s1house, missing

* 17) t0dadpce=s1q81a

tab s1q81a, missing
tab s1q81a, missing nolabel

gen t0dadpce=s1q81a
recode t0dadpce 1=1 2=2 -8=3 -9=-9
label define t0dadpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0dadpce t0dadpce1
label variable t0dadpce "father had post-compulsory education" 
numlabel t0dadpce1, add
tab t0dadpce, missing

* 18) t0mumpce=s1q81b

tab s1q81b, missing

gen t0mumpce=s1q81b
recode t0mumpce 1=1 2=2 -8=3 -9=-9
label define t0mumpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumpce t0mumpce1
label variable t0mumpce "mother had post-compulsory education" 
numlabel t0mumpce1, add
tab t0mumpce, missing

* 19) t0dadalv=s1q81a

tab s1q81a, missing
tab s1q81a, missing nolabel

gen t0dadalv=s1q81a
recode t0dadalv 1=1 2=2 -8=3 -9=-9
label define t0dadalv1 -9 "not answered" 1 "yes" 2 "no" 3 "not sure"
label values t0dadalv t0dadalv1
label variable t0dadalv "did your father obtain one or more a levels?" 
numlabel t0dadalv1, add
tab t0dadalv, missing

* 20) t0mumalv=s1q81b

tab s1q81b, missing

gen t0mumalv=s1q81b
recode t0mumalv 1=1 2=2 -8=3 -9=-9
label define t0mumalv1 -9 "not answered" 1 "yes" 2 "no" 3 "not sure"
label values t0mumalv t0mumalv1
label variable t0mumalv "did your mother obtain one or more a levels?" 
numlabel t0mumalv1, add
tab t0mumalv, missing

* 21) t0daddeg=s1q82a

tab s1q82a, missing
tab s1q82a, missing nolabel

gen t0daddeg=s1q82a
recode t0daddeg 1=1 2=2 -8=3 -9=-9
label define t0daddeg1 -9 "not answered" 1 "yes" 2 "no" 3 "not sure"
label values t0daddeg t0daddeg1
label variable t0daddeg "did your father obtain a degree?" 
numlabel t0daddeg1, add
tab t0daddeg, missing

* 22) t0mumdeg=s1q82b

tab s1q82b, missing

gen t0mumdeg=s1q82b
recode t0mumdeg 1=1 2=2 -8=3 -9=-9
label define t0mumdeg1 -9 "not answered" 1 "yes" 2 "no" 3 "not sure"
label values t0mumdeg t0mumdeg1
label variable t0mumdeg "did your mother obtain a degree?" 
numlabel t0mumdeg1, add
tab t0mumdeg, missing

*  23) t0dadjob=s1q75a

tab s1q75a, missing

gen t0dadjob=s1q75a
* recode t0dadjob 1=1 2=2 -9=-9
label define t0dadjob1 -9 "not answered" 1 "yes" 2 "no"
label values t0dadjob t0dadjob1
label variable t0dadjob "is your father employed full-time at the moment?" 
numlabel t0dadjob1, add
tab t0dadjob, missing

* 24) t0mumjob=s1q75b

tab s1q75b, missing

gen t0mumjob=s1q75b
* recode t0mumjob 1=1 2=2 -9=-9
label define t0mumjob1 -9 "not answered (9)" 1 "yes" 2 "no"
label values t0mumjob t0mumjob1
label variable t0mumjob "is your mother employed full-time at the moment?" 
numlabel t0mumjob1, add
tab t0mumjob, missing

* 25) t0truant=s1q89

tab s1q89, missing
tab s1q89, missing nolabel

gen t0truant=s1q89
recode t0truant 1=1 2=2 3/4=3 5=4 -9=-9
label define t0truant1 ///
-9 "not answered" ///
1 "weeks at a time" ///
2 "days at a time" ///
3 "occasional days or lessons" ///
4 "never"

label values t0truant t0truant1
label variable t0truant "truancy in y11/s4" 
numlabel t0truant1, add
tab t0truant, missing

* 26) t1att1=s1q91a

tab s1q91a, missing
tab s1q91a, missing nolabel

gen t1att1=s1q91a
label define t1att11 -9 "not answered" 1 "agree" 2 "disagree"
label values t1att1 t1att11
label variable t1att1 "schl has given me confidence to make decisions" 
numlabel t1att11, add
tab t1att1, missing

* 27) t1att2=s1q91b

tab s1q91b, missing

gen t1att2=s1q91b
label define t1att21 -9 "not answered" 1 "agree" 2 "disagree"
label values t1att2 t1att21
label variable t1att2 "schl done little to prepare me for life after school" 
numlabel t1att21, add
tab t1att2, missing

* 28) t1att3=s1q91c

tab s1q91c, missing

gen t1att3=s1q91c
label define t1att31 -9 "not answered" 1 "agree" 2 "disagree"
label values t1att3 t1att31
label variable t1att3 "schl taught things useful in a job" 
numlabel t1att31, add
tab t1att3, missing

* 29) t0region=s1gor

tab s1gor, missing
tab s1gor, missing nolabel

tab s1ssr, mi

clonevar t0region=s1ssr
tab t0region, missing
tab t0region s1gor, missing

* 30) t0dadsoc=ns1socf
* 31) t0mumsoc=ns1socm

* tab1 ns1socf ns1socm, missing
gen t0dadsoc=soc2
gen t0mumsoc=soc3

mvdecode t0dadsoc t0mumsoc, mv(-9)

codebook t0dadsoc t0mumsoc

* tab1 ns1socf ns1socm, missing

* 32 - 39 are qualifications. Will return to later

* Skipping 40 - 42 (Not used in analysis)

* 43) t0dadse=s1q79a

tab s1q79a, missing
gen t0dadse=s1q79a
mvdecode t0dadse, mv (-8 -9)
mvencode t0dadse, mv (-9)
label define t0dadse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0dadse t0dadse1
label variable t0dadse "is/was your father self-employed?" 
numlabel t0dadse1, add
tab t0dadse, missing

** 44) t0mumse=s1q79b

tab s1q79b, missing
gen t0mumse=s1q79b
mvdecode t0mumse, mv (-8 -9)
mvencode t0mumse, mv (-9)
label define t0mumse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0mumse t0mumse1
label variable t0mumse "is/was your mother self-employed?" 
numlabel t0mumse1, add
tab t0mumse, missing

* 45) t0gor

clonevar t0gor=s1gor
tab t0gor, missing

* Skipping 46 - 48 (not used in analysis)

* 49) t0parsec

tab1 nssec1 nssec2, missing

* Too many missing for these

tab1 s1nssecf s1nssecm, mi

* Use the above to create semi-dominance measure

* Skipping 50 - 66 (not used in analysis)

***

* Harmonised variables file

keep t0* s1nssecf s1nssecm
order s1nssecf s1nssecm, last

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs11_background_vars.dta, replace

clear

* END * 
