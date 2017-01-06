* 20th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS10 Preparation of respondent background information

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

 global path2 "A:\YCS\github_ycs_subject_analysis\"
 global path3 "A:\YCS\github_ycs_subject_analysis\data\"
 global path4 "A:\data\YCS_time_series\stata8\"

* Moved file to temporary location because network connection too slow
global path10 "C:\Users\cplayfor\Documents\temp\"

clear
set more off

* Reducing the number of variables - dataset takes an age to load.

use ///
a1_1	 ///
a1_2	 ///
a1_3	 ///
a11_10c	 ///
a11_11c	 ///
a11_11d	 ///
a11_1a	 ///
a11_1a	 ///
a11_1a	 ///
a11_1b	 ///
a11_1b	 ///
a11_1b	 ///
a11_1c	 ///
a11_2a	 ///
a11_2b	 ///
a11_2c	 ///
a11_3a	 ///
a11_3b	 ///
a11_3c	 ///
a11_4a	 ///
a11_4b	 ///
a11_4c	 ///
a11_5a	 ///
a11_5b	 ///
a11_5c	 ///
a11_6a	 ///
a11_6b	 ///
a11_6c	 ///
a11_7a	 ///
a11_7b	 ///
a11_7c	 ///
a11_8a	 ///
a11_8b	 ///
a11_8c	 ///
a11_9a	 ///
a11_9b	 ///
a11_9c	 ///
a11oga1	 ///
a11oga2	 ///
a11oga3	 ///
a11oga4	 ///
a11oga5	 ///
a11oga6	 ///
a11ogb1	 ///
a11ogb2	 ///
a11ogb3	 ///
a11ogb4	 ///
a11ogb5	 ///
a11ogb6	 ///
a11ogc1	 ///
a11ogc2	 ///
a11ogc3	 ///
a11ogc4	 ///
a11ogc5	 ///
a11ogc6	 ///
a11or1	 ///
a11or2	 ///
a11or3	 ///
a56_a6b	 ///
a57fa	 ///
a57fe	 ///
a57fg	 ///
a57fg	 ///
a57fh	 ///
a57ma	 ///
a57me	 ///
a57mg	 ///
a57mg	 ///
a57mh	 ///
a58	 ///
a61	 ///
a9	 ///
ns1socf	 ///
ns1socm	 ///
nssec1	 ///
s1estab	 ///
s1gor	 ///
s1gor	 ///
s1house	 ///
s1live	 ///
s1oct99	 ///
s1sex	 ///
s2oct00	 ///
s3basic	 ///
s3oct01	 ///
s3q28	 ///
s3q29	 ///
s3q4d	 ///
s3q4j	 ///
s3q4j	 ///
sweep1	 ///
using $path10\ycs10final.dta, clear

numlabel _all, add

* YCS10 Data Dictionary
* A:\data\YCS_Cohort_10_Download\mrdoc\allissue\ycs10final_UKDA_Data_Dictionary.docx

* YCS10 User Guide
* A:\data\YCS_Cohort_10_Download\mrdoc\pdf\4571userguide.pdf

***

* 1) t0cohort

gen t0cohort=1999
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

* 3) t0caseid - This is missing from SN4571

gen t0caseid = .
label variable t0caseid "id for time series"
codebook t0caseid

* New ID variable created based on order in dataset (ycs10_id)

gen ycs10_id = _n
label variable ycs10_id "ID variable created - based on position in YCS10"
codebook ycs10_id

* 4) t0source = ycs10

gen t0source = "ycs10"
label variable t0source "source of data"
tab t0source

*** WEIGHTINGS.

* 5) t1weight=sweep1
gen t1weight=sweep1
label variable t1weight "weight s1"

/* THERE IS NO t2 in ycs10	sweep2?
* 6) t2weight=sw1v14
gen t2weight=sw1v14
label variable t2weight "weight s2" */

* 7) t3weight=s3basic
gen t3weight=s3basic
label variable t3weight "weight s3"

codebook t1weight t3weight

* 8 - 10 Not sure what has happened to t1resp - t3resp
* These don't appear to be there...

* 11) t0schtyp=s1estab

tab s1estab, missing
tab s1estab, nolabel missing

gen t0schtyp=s1estab
mvdecode t0schtyp, mv(-99.99,7)
recode t0schtyp 1=2 2=3 3=4 4=5 5=7 6=6
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
numlabel _all, add
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

gen t0stay = s1live
mvdecode t0stay, mv(5)
recode t0stay 1=3 2=2 3=4 4=1
mvencode t0stay, mv(-9)

tab t0stay, missing
tab s1live t0stay, missing 

label define t0stay1 ///
1  "father and mother" ///
2  "mother only" ///
3  "father only" ///
4  "other response" ///
-9 "not answered"

label values t0stay t0stay1
label variable t0stay "household at t1"
numlabel _all, add

tab t0stay, missing
tab t0stay s1live, missing

* 14) t0sibs = a56_a6b (a56_a6b is collapsed version, a56_a6a indicates brothers and sisters)

tab1 a56_a6b, missing

* Going to leave this one.

* 15) t0ethnic = a58

tab a58, missing

gen t0ethnic = a58
mvdecode t0ethnic, mv(11,13)
recode t0ethnic 1=1 2/4=4 5=5 6=6 7=7 8/9=9 10=10 12=10
mvencode t0ethnic, mv(-9)

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
tab t0ethnic a58, missing

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

* 17) t0dadpce=a57fg

tab a57fg, missing

gen t0dadpce=a57fg
recode t0dadpce 1=1 2=2 3=3 -99.99=-9
label define t0dadpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0dadpce t0dadpce1
label variable t0dadpce "father had post-compulsory education" 
numlabel t0dadpce1, add
tab t0dadpce, missing

* 18) t0mumpce=a57mg

tab a57mg, missing

gen t0mumpce=a57mg
recode t0mumpce 1=1 2=2 3=3 -99.99=-9
label define t0mumpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumpce t0mumpce1
label variable t0mumpce "mother had post-compulsory education" 
numlabel t0mumpce1, add
tab t0mumpce, missing

* 19) t0dadalv=a57fg

tab a57fg, missing

gen t0dadalv=a57fg
recode t0dadalv 1=1 2=2 3=3 -99.99=-9
label define t0dadalv1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0dadalv t0dadalv1
label variable t0dadalv "did your father obtain one or more a levels?" 
numlabel t0dadalv1, add
tab t0dadalv, missing

* 20) t0mumalv=a57mg

tab a57mg, missing

gen t0mumalv=a57mg
recode t0mumalv 1=1 2=2 3=3 -99.99=-9
label define t0mumalv1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumalv t0mumalv1
label variable t0mumalv "did your mother obtain one or more a levels?" 
numlabel t0mumalv1, add
tab t0mumalv, missing

* 21) t0daddeg=a57fh

tab a57fh, missing

gen t0daddeg=a57fh
recode t0daddeg 1=1 2=2 3=3 -99.99=-9
label define t0daddeg1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0daddeg t0daddeg1
label variable t0daddeg "did your father obtain a degree?" 
numlabel t0daddeg1, add
tab t0daddeg, missing

* 22) t0mumdeg=a57mh

tab a57mh, missing

gen t0mumdeg=a57mh
recode t0mumdeg 1=1 2=2 3=3 -99.99=-9
label define t0mumdeg1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumdeg t0mumdeg1
label variable t0mumdeg "did your mother obtain a degree?" 
numlabel t0mumdeg1, add
tab t0mumdeg, missing

*  23) t0dadjob=a57fa

tab a57fa, missing

gen t0dadjob=a57fa
recode t0dadjob 1=1 2=2 -99.99=-9
label define t0dadjob1 -9 "not answered (9)" 1 "yes" 2 "no"
label values t0dadjob t0dadjob1
label variable t0dadjob "is your father employed full-time at the moment?" 
numlabel t0dadjob1, add
tab t0dadjob, missing

* 24) t0mumjob=a57ma

tab a57ma, missing

gen t0mumjob=a57ma
recode t0mumjob 1=1 2=2 -99.99=-9
label define t0mumjob1 -9 "not answered (9)" 1 "yes" 2 "no"
label values t0mumjob t0mumjob1
label variable t0mumjob "is your mother employed full-time at the moment?" 
numlabel t0mumjob1, add
tab t0mumjob, missing

* 25) t0truant=a61

tab a61, missing

gen t0truant=a61
recode t0truant 1=1 2=2 3/4=3 5=4 -99.99=-9

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

* 26) t1att1=a1_1

tab a1_1, missing

gen t1att1=a1_1
mvdecode t1att1, mv (-99.99)
mvencode t1att1, mv (-9)
label define t1att11 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att1 t1att11
label variable t1att1 "schl has given me confidence to make decisions" 
numlabel t1att11, add
tab t1att1, missing

* 27) t1att2=a1_2

tab a1_2, missing

gen t1att2=a1_2
mvdecode t1att2, mv (-99.99)
mvencode t1att2, mv (-9)
label define t1att21 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att2 t1att21
label variable t1att2 "schl done little to prepare me for life after school" 
numlabel t1att21, add
tab t1att2, missing

* 28) t1att3=a1_3

tab a1_3, missing

gen t1att3=a1_3
mvdecode t1att3, mv (-99.99)
mvencode t1att3, mv (-9)
label define t1att31 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att3 t1att31
label variable t1att3 "schl taught things useful in a job" 
numlabel t1att31, add
tab t1att3, missing

* 29) t0region=sw1v9

tab s1gor, missing

gen t0region=.
replace t0region=1  if s1gor==4
replace t0region=2  if s1gor==10
replace t0region=3  if s1gor==5
replace t0region=4  if s1gor==1
replace t0region=5  if s1gor==9
replace t0region=6  if s1gor==2
replace t0region=7  if s1gor==3 | s1gor==6
replace t0region=8  if s1gor==7
replace t0region=9  if s1gor==8
replace t0region=10 if s1gor==11

label define t0region1 ///
1 "north" ///
2 "yorks & humber" ///
3 "north west" ///
4 "east midlands" ///
5 "west midlands" ///
6 "east anglia" ///
7 "greater london" ///
8 "other south east" ///
9 "south west" ///
10 "wales"
label values t0region t0region1
label variable t0region "standard statistical regions"
numlabel t0region1, add

tab t0region, missing
tab t0region s1gor, missing

* 30) t0dadsoc=ns1socf
* 31) t0mumsoc=ns1socm

* tab1 ns1socf ns1socm, missing
* t0dadsoc		ns1socf		/* SOC2000 Occupations - but without the code! */
* t0mumsoc		ns1socm		/* SOC2000 Occupations - but without the code! */

do $path2\3_ycs10_soc2000_recode.do"
do $path2\3_soc2000_labels.do"

label values t0dadsoc2000 t0mumsoc2000 soc2000
label variable t0dadsoc2000 "SOC2000 code of fathers’ occupation"
label variable t0mumsoc2000 "SOC2000 code of mothers’ occupation"

codebook t0dadsoc2000 t0mumsoc2000

set more off
numlabel _all, add
tab1 t0dadsoc2000 t0mumsoc2000, mi

* tab ns1socf ns1socm, mi

* 32 - 39 are qualifications. Will return to later

* Skipping 40 - 42 (Not used in analysis)

* 43) t0dadse=a57fe

tab a57fe, missing
gen t0dadse=a57fe
mvdecode t0dadse, mv (-99.99)
mvencode t0dadse, mv (-9)
label define t0dadse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0dadse t0dadse1
label variable t0dadse "is/was your father self-employed?" 
numlabel t0dadse1, add
tab t0dadse, missing

** 44) t0mumse=a57me

tab a57me, missing
gen t0mumse=a57me
mvdecode t0mumse, mv (-99.99)
mvencode t0mumse, mv (-9)
label define t0mumse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0mumse t0mumse1
label variable t0mumse "is/was your mother self-employed?" 
numlabel t0mumse1, add
tab t0mumse, missing

* 45) t0gor (very similar to t0region)

tab t0region, missing

gen t0gor=t0region
recode t0gor (2=3) (3=2)
label define t0gor1 ///
1 "north east" ///
2 "north west" ///
3 "yorkshire & humberside" ///
4 "east midlands" ///
5 "west midlands" ///
6 "east of england" ///
7 "london" ///
8 "south east" ///
9 "south west" ///
10 "wales"
label values t0gor t0gor1
label variable t0gor "government office region"
numlabel t0gor1, add
tab t0gor, missing

* Skipping 46 - 48 (not used in analysis)

* 49) t0parsec

* tab nssec1, missing
* clonevar t0parsec = nssec1
* tab t0parsec, missing

* Skipping 50 - 66 (not used in analysis)

***

* Harmonised variables file

keep ycs10_id t*
order ycs10_id

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs10_background_vars.dta, replace

clear

* END * 
