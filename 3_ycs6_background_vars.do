* 21st December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS6 Preparation of respondent background information

* The location of the folder containing the YCS wave 6 data

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
use $path6\cohort6.dta, clear
numlabel _all, add

* YCS6 Data Dictionary
* A:\data\YCS_Cohort_6_Download\mrdoc\allissue\cohort6_UKDA_Data_Dictionary.docx

* YCS6 User Guide
* A:\data\YCS_Cohort_6_Download\mrdoc\pdf\3532userguide.pdf

***

** 1) t0cohort

gen t0cohort=1992
label variable t0cohort "year completed compulsory schooling"
tab t0cohort

** 2) t0nation

gen t0nation=sw1v2
tab t0nation
recode t0nation 1/9=1 10=2
label define t0nation1 1 "England" 2 "Wales"
label values t0nation t0nation1
label variable t0nation "national system"
tab t0nation

** 3) t0caseid 

clonevar t0caseid=id
summarize t0caseid
codebook t0caseid
help label
label variable t0caseid "id for time series"
codebook t0caseid

** 4) t0source = ycs6

gen t0source = "ycs6"
label variable t0source "source of data"
tab t0source

*** WEIGHTINGS.

** 5) t1weight=sw1v13
gen t1weight=sw1v13
label variable t1weight "weight s1"

** 6) t2weight=sw1v14
gen t2weight=sw1v14
label variable t2weight "weight s2"

** 7) t3weight=sw1v15
gen t3weight=sw1v15
label variable t3weight "weight s3"

*** RESPONDENTS IN DIFF WAVES (attrition)

** 8) t1resp=sw1v10

gen t1resp=sw1v10
label variable t1resp "responded to t1 survey"
recode t1resp .=0 1=1
label define t1resp1 0 "did not respond" 1 "respondent"
label values t1resp t1resp1
tab t1resp
tab t1resp, missing

** 9) t2resp=sw1v11

gen t2resp=sw1v11
label variable t2resp "responded to t2 survey"
recode t2resp .=0 1=1
label define t2resp1 0 "did not respond" 1 "respondent"
label values t2resp t2resp1
tab t2resp
tab t2resp, missing

** 10) t3resp=sw1v12

gen t3resp=sw1v12
label variable t3resp "responded to t3 survey"
recode t3resp .=0 1=1
label define t3resp1 0 "did not respond" 1 "respondent"
label values t3resp t3resp1
tab t3resp
tab t3resp, missing

tab2 t3resp t2resp t1resp

*** SCHOOL TYPE

** 11) t0schtyp=sw1v1 but with recode

tab sw1v1, missing
gen t0schtyp=sw1v1
tab t0schtyp
label define t0schtyp1 1 "6th form college" 2 "comp to 16" 3 "comp to 18" ///
4 "grammar" 5 "sec modern" 6 "other state funded" 7 "independent" 8 "ctc"
label values t0schtyp t0schtyp1
label variable t0schtyp "school type"
numlabel _all, add
tab t0schtyp

** 12) t0sex=sw1v6

tab sw1v6, missing
describe sw1v6
gen t0sex=sw1v6
label variable t0sex "gender"
label values t0sex sw1v6
tab t0sex

** 13) t0stay=sw1v386 and sw1v387 use missing command

tab sw1v386, missing
tab sw1v387, missing
tab sw1v386 sw1v387
tab sw1v386 sw1v387, missing

* We reckon that the unlabelled cat 2 (20 people are mother only)

* 1 = (sw1v386=1 AND sw1v387=2)
* 2 = (sw1v386=2) OR (sw1v386=. AND sw1v387=2)
* 3 = (sw1v386=1 AND sw1387=.)
* 4 = (sw1v386=7,8)
* -9 = (sw1v386=9) OR (sw1v386=. AND sw1387=.)

* Here are the new categories for t0stay derived from father/mother info

gen t0stay=1 if (sw1v386==1 & sw1v387==2)
replace t0stay=2 if (sw1v386==2) | (sw1v386==. & sw1v387==2)
replace t0stay=3 if (sw1v386==1 & sw1v387==.)
replace t0stay=4 if (sw1v386==7)|(sw1v386==8)
replace t0stay=-9 if ((sw1v386==9)| (sw1v386==. & sw1v387==.))

* Vernon mentioned the possibility of declaring all missing first...

label define t0stay1 -9 "not answered" 1 "father and mother" 2 "mother only" ///
3 "father only" 4 "other response"
label values t0stay t0stay1
label variable t0stay "household at t1"
numlabel _all, add
tab t0stay
tab t0stay, missing

***

** 14) t0sibs= brothers sw1v388 & sw1v389 plus sisters sw1v390 & sw1v391

tab sw1v389 sw1v388, missing
tab sw1v391 sw1v390, missing

* Mysteriously, there are 23 people who say they have bros in hh but also 0!

tab sw1v388 sw1v390, missing

* Siblings:
* 0=missing number + no bros + no sis
* else = number of bros + number of sis
* discount example provided above (i.e. the impossible).
* also =9 as this is a missing code (it would suggest)

gen t0bro=sw1v389
replace t0bro=0 if (sw1v389==.)
mvdecode t0bro, mv (9)
tab t0bro, missing
tab sw1v389, missing

gen t0sis=sw1v391
mvdecode t0sis, mv (9)
replace t0sis=0 if (sw1v391==.)
tab t0sis, missing
tab sw1v391, missing

gen t0sibs= t0bro + t0sis
label variable t0sibs "siblings in household"
tab t0sibs
tab t0sibs, missing
mvencode t0sibs, mv (-9)
tab sw1v388 sw1v390, missing

***

** 15) t0ethnic=sw1v406 and sw1v407 (asian grouping) with recode

tab sw1v406
tab sw1v406, missing

tab sw1v407, missing

** missing is probably cat 9 *

gen t0ethnic=1 if (sw1v406==1)
replace t0ethnic=4 if (sw1v406==2)
replace t0ethnic=5 if (sw1v407==1)
replace t0ethnic=6 if (sw1v407==2)
replace t0ethnic=7 if (sw1v407==3)
replace t0ethnic=9 if (sw1v407==4) | (sw1v407==5)
replace t0ethnic=10 if (sw1v406==4)

mvdecode sw1v406 sw1v407, mv (9)
mvencode t0ethnic, mv (-9)

* Be wary of mvdecode when used with source variables but best for this example.
* As an alternative could construct intermediate variables so that source is unchanged.
* Need to remember space below when specifying line continuation

label variable t0ethnic "ethnic classification"
label define t0ethnic1 -9 "not answered" 1 "white" 4 "black" 5 "indian" ///
6 "pakistani" 7 "bangladeshi" 9 "other asian" 10 "other response"
label values t0ethnic t0ethnic1
numlabel t0ethnic1, add
numlabel, add
tab t0ethnic, missing

***

** 16) t0house=sw1v408 with recode

tab sw1v408, missing

* 1 owned
* 2,3,4 rented
* 5,6,7,8 other
* 9 not answered/missing

gen t0house=sw1v408
recode t0house 1=1 2/4=2 5/8=3 9=-9
label define t0house1 -9 "not answered" 1 "owned" 2 "rented" 3 "other"
label values t0house t0house1
numlabel t0house1, add
label variable t0house "parents housing type" 
tab t0house, missing

***

* Parents post comp education

** 17) t0dadpce=sw2v324
tab sw2v324, missing

gen t0dadpce=sw2v324
recode t0dadpce 1=1 2=2 3/4=3 9=-9
label define t0dadpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0dadpce t0dadpce1
label variable t0dadpce "father had post-compulsory education" 
numlabel t0dadpce1, add
tab t0dadpce, missing

***

** 18) t0mumpce=sw2v326
* See above

tab sw2v326, missing

gen t0mumpce=sw2v326
recode t0mumpce 1=1 2=2 3/4=3 9=-9
label define t0mumpce1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumpce t0mumpce1
label variable t0mumpce "mother had post-compulsory education" 
numlabel t0mumpce1, add
tab t0mumpce, missing

***

** 19) t0dadalv=sw2v325

tab sw2v325, missing
gen t0dadalv=sw2v325
recode t0dadalv 1=1 2=2 3/4=3 9=-9
label define t0dadalv1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0dadalv t0dadalv1
label variable t0dadalv "did your father obtain one or more a levels?" 
numlabel t0dadalv1, add
tab t0dadalv, missing

** 20) t0mumalv=sw2v327

tab sw2v327, missing
gen t0mumalv=sw2v327
recode t0mumalv 1=1 2=2 3/4=3 9=-9
label define t0mumalv1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumalv t0mumalv1
label variable t0mumalv "did your mother obtain one or more a levels?" 
numlabel t0mumalv1, add
tab t0mumalv, missing

***

* D/K stands for "Don't Know" *

** 21) t0daddeg=sw1v404

tab sw1v404, missing
tab sw1v404 t0stay, missing

gen t0daddeg=sw1v404
tab t0daddeg
describe t0daddeg

recode t0daddeg (1=1) (2=2) (3 4 8 = 3) (9=-9)
label define t0daddeg1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0daddeg t0daddeg1
label variable t0daddeg "did your father obtain a degree?" 
numlabel t0daddeg1, add
tab t0daddeg, missing

** 22) t0mumdeg=sw1v405

tab sw1v405, missing

gen t0mumdeg=sw1v405
recode t0mumdeg (1=1) (2=2) (3 4 8 = 3) (9=-9)
label define t0mumdeg1 -9 "not answered" 1 "yes" 2 "no" 3 "other response"
label values t0mumdeg t0mumdeg1
label variable t0mumdeg "did your mother obtain a degree?" 
numlabel t0mumdeg1, add
tab t0mumdeg, missing

***

**  23) t0dadjob=sw1v396

tab sw1v396, missing

gen t0dadjob=sw1v396
mvdecode t0dadjob, mv (8,9)
tab t0dadjob, missing

mvencode t0dadjob, mv (-9)
label define t0dadjob1 -9 "not answered (9)" 1 "yes" 2 "no"
label values t0dadjob t0dadjob1
label variable t0dadjob "is your father employed full-time at the moment?" 
numlabel t0dadjob1, add
tab t0dadjob, missing

** 24) t0mumjob=sw1v397

tab sw1v397, missing

gen t0mumjob=sw1v397
mvdecode t0mumjob, mv (8,9)
tab t0mumjob, missing

mvencode t0mumjob, mv (-9)
label define t0mumjob1 -9 "not answered (9)" 1 "yes" 2 "no"
label values t0mumjob t0mumjob1
label variable t0mumjob "is your mother employed full-time at the moment?" 
numlabel t0mumjob1, add
tab t0mumjob, missing

***

** 25) t0truant=sw1v64

numlabel _all, add
tab sw1v64, missing

gen t0truant=sw1v64
mvdecode t0truant, mv (9)
tab t0truant, missing
mvencode t0truant, mv (-9)
tab t0truant, missing

recode t0truant 1=1 2=2 3/4=3 5=4
label define t0truant1 -9 "not answered" 1 "weeks at a time" 2 "days at a time" ///
3 "occasional days or lessons" 4 "never"
label values t0truant t0truant1
label variable t0truant "truancy in y11/s4" 
numlabel t0truant1, add
tab t0truant, missing

***

** 26) t1att1=sw1v58
** 27) t1att2=sw1v60
** 28) t1att3=sw1v61

tab sw1v58, missing
tab sw1v60, missing
tab sw1v61, missing

gen t1att1=sw1v58
mvdecode t1att1, mv (8,9)
mvencode t1att1, mv (-9)
label define t1att11 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att1 t1att11
label variable t1att1 "schl has given me confidence to make decisions" 
numlabel t1att11, add
tab t1att1, missing

gen t1att2=sw1v60
mvdecode t1att2, mv (8,9)
mvencode t1att2, mv (-9)
label define t1att21 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att2 t1att21
label variable t1att2 "schl done little to prepare me for life after school" 
numlabel t1att21, add
tab t1att2, missing

gen t1att3=sw1v61
mvdecode t1att3, mv (8,9)
mvencode t1att3, mv (-9)
label define t1att31 -9 "not answered (9)" 1 "agree" 2 "disagree"
label values t1att3 t1att31
label variable t1att3 "schl taught things useful in a job" 
numlabel t1att31, add
tab t1att3, missing

***

** 29) t0region=sw1v9

tab sw1v2, missing
tab sw1v9, missing

* Clearly sw1v2 - aside, interesting when you tab sw1v2 by sw1v9

gen t0region=sw1v2
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

***

* SOC90 codes

** 30) t0dadsoc=sw1v398
** 31) t0mumsoc=sw1v400

tab sw1v398, missing
describe sw1v398
gen t0dadsoc=sw1v398
gen t0mumsoc=sw1v400

label variable t0dadsoc "SOC90 code of fathers’ occupation"
label variable t0mumsoc "SOC90 code of mothers’ occupation"

** SUBJECTS AND EXAMS DIFFERENT FILE

** 32) t0examst
* label variable "num of y11 exam courses studied"

** 33) t0examac
* label variable "num of a-c awards in y11 or s4 exams"

** 34) t0examaf
* label variable "num of a-f awards in y11 or s4 exams"

** 35) t0score
* label variable "point score from y11 or s4 exams"

***
** 36) t0vocsbj
* label variable "tot voc subjects studied y11"

** 37) t0vocpas
* label variable "tot voc subjects passed y11"

** 38) t0othsbj
* label variable "other courses studied y11"

** 39) t0othpas
* label variable "other courses passed y11"

***

* School leaving datas

tab1 sw1v187 sw1v188 sw1v189, missing
tab sw1v189 if (sw1v188==2)

tab sw1v202 sw1v187, missing

gen mschleave=sw1v188
mvdecode mschleave, mv (98 99)
tab mschleave, missing

gen yschleave=sw1v189
mvdecode yschleave, mv (98 99)
tab yschleave, missing

gen schldate = mdy(mschleave, 28, yschleave+1900)
format schldate %d
tab schldate, missing
tab schldate sw1v187, missing

tab sw1v202 sw1v187, missing
tab schldate sw1v187 if sw1v202==4, missing

* The above is good news. 
* There are no students with a leaving date who claim to have not left school.

** 40) t1dooct

tab sw1v202, missing

* I have split category 4 into school and 6 form.

gen t1dooct=.
replace t1dooct=1 if (sw1v202==4 & sw1v187==2)
replace t1dooct=2 if (sw1v202==4 & sw1v187!=2)
replace t1dooct=3 if (sw1v202==5)
replace t1dooct=5 if (sw1v202==3)
replace t1dooct=6 if (sw1v202==2)
replace t1dooct=8 if (sw1v202==1)
replace t1dooct=10 if (sw1v202==6)
mvencode t1dooct, mv (-9)
tab t1dooct, missing
tab sw1v202 sw1v187, missing
capture log using $path1\t1dooct.txt, replace text

label define t1dooct1 ///
1 "School" ///
2 "6th form college" ///
3 "fe college" ///
4 "education - inst nk" ///
5 "training scheme" ///
6 "ft job" ///
7 "pt job" ///
8 "unemployed" ///
9 "home or family" ///
10 "other"
label values t1dooct t1dooct1
label variable t1dooct "destination in october following end y11/s4"
numlabel t1dooct1, add
tab t1dooct, missing

** 41) t1donow

tab sw1v207 sw1v187, missing

gen t1donow=.
replace t1donow=1 if (sw1v207==4 & sw1v187==2)
replace t1donow=2 if (sw1v207==4 & sw1v187!=2)
replace t1donow=5 if (sw1v207==3)
replace t1donow=6 if (sw1v207==2)
replace t1donow=7 if (sw1v207==7)
replace t1donow=8 if (sw1v207==1)
replace t1donow=9 if (sw1v207==5)
replace t1donow=10 if (sw1v207==6)
mvencode t1donow, mv (-9)
tab t1donow, missing
tab sw1v207 sw1v187, missing

label define t1donow1 ///
1 "School" ///
2 "6th form college" ///
3 "fe college" ///
4 "education - inst nk" ///
5 "training scheme" ///
6 "ft job" ///
7 "pt job" ///
8 "unemployed" ///
9 "home or family" ///
10 "other"
label values t1donow t1donow1
label variable t1donow "destination in spring following end y11/s4"
numlabel t1donow1, add
tab t1donow, missing

***

** 42) t0age

* I think this is supposed to be relative to the sample date (i.e. to 1992 for YCS 6)

tab sw1v3, missing
tab sw1v4, missing
tab sw1v5, missing


gen bdate = mdy(sw1v4, sw1v5, sw1v3+1900)
format bdate %td

gen t0agedate = mdy(6,30,1991)

gen t0age=(t0agedate-bdate)/365.25
tab t0age, missing
label variable t0age "age on 30 june 1991"
codebook t0age

***

** 43) t0dadse=sw1v402

tab sw1v402, missing
gen t0dadse=sw1v402
mvdecode t0dadse, mv (8 9)
mvencode t0dadse, mv (-9)
label define t0dadse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0dadse t0dadse1
label variable t0dadse "is/was your father self-employed?" 
numlabel t0dadse1, add
tab t0dadse, missing

** 44) t0mumse=sw1v403

tab sw1v403, missing
gen t0mumse=sw1v403
mvdecode t0mumse, mv (8 9)
mvencode t0mumse, mv (-9)
label define t0mumse1 -9 "not answered (9)" -1 "item not applicable" 1 "agree" 2 "disagree"
label values t0mumse t0mumse1
label variable t0mumse "is/was your mother self-employed?" 
numlabel t0mumse1, add
tab t0mumse, missing

***

** 45) t0gor

tab sw1v2, missing

gen t0gor=sw1v2
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

tab sw1v2 sw1v9, missing

***

** 46) t0urban

* label variable "top 8 urban areas in 1981 and 91"
* I don't think I can do this.

***

* The following are done in GEODE

** 47) t0mumsec
* label variable "mothers sec -9 class"

** 48) t0dadsec
* label variable "fathers sec -9 class"

** 49) t0parsec
* label variable "parents sec -9 class"

** 50) t0dadsc4
* label variable "fathers sec - 4 class"

** 51) t0mumsc4
* label variable "mothers sec - 4 class"

** 52) t0parsc4
* label variable "parents sec - 4 class"

***

** 53) t0monthb=sw1v4

tab sw1v4, missing
gen t0monthb=sw1v4
label define t0monthb1 1 "january" 2 "february" 3 "march" 4 "april" 5 "may" 6 "june" ///
                       7 "july" 8 "august" 9 "september" 10 "october" 11 "november" 12 "december"
label values t0monthb t0monthb1
label variable t0monthb "month of birth" 
numlabel t0monthb1, add
tab t0monthb, missing

***

* T3 EDUCATIONAL VARIABLES IN ANOTHER FILE

** 54) t3alev
* label variable "achieved 1+ a-level course by t3"

** 55) t3nqf_a
* label variable "highest nqf level of academic quals achieved"

** 56) t3_ucas
* label variable "total ucas point score"

** 57) t3uscore
* label variable "total  point score"

** 58) t3lev3
* label variable "achieved nqf level 3"

** 59) t3twoa
* label variable "achieved 2 a-levels"

***

** 60) t3nowed

tab sw3v21, missing

gen t3nowed=sw3v21
recode t3nowed (1 2 3 5 6 7 = 0) (4 = 1)
label define t3nowed1 0 "in other status" 1 "in full-time education"
label values t3nowed t3nowed1
label variable t3nowed "currently in full-time education" 
numlabel t3nowed1, add
tab t3nowed, missing
tab t3nowed t3resp, missing

***

** 61) t3nowhe

tab sw3v21, missing
tab sw3v148, missing

if sw3v21==4 tab sw3v148, missing
if sw3v21!=4 tab sw3v148, missing

gen t3nowhe=sw3v148
recode t3nowhe (6 9 = -9) (1 2 3 4 = 0) (5 = 1)
label define t3nowhe1 -9 "missing information" 0 "no, not in he but in other non-advanced courses" 1 "yes, in he" 
label values t3nowhe t3nowhe1
label variable t3nowhe "currently in he"
numlabel t3nowhe1, add
tab t3nowhe, missing
tab t3nowhe t3resp, missing

* I have changed the label for 0 as it appears to be a typo in the ew_core codebook
* The following four variables are related to questions around application (page 12 of sw3 questionnaire).
* tab1 sw3v444 sw3v445 sw3v446 sw3v447, missing

***

** 62) t3degree

tab sw3v148 sw3v150, missing

tab sw3v198, missing
tab t3nowhe sw3v198, missing

tab sw3v198 sw3v150, missing

tab sw3v148 sw3v198, missing
tab sw3v148 sw3v150, missing

* The above are pretty consistent measures.

tab sw3v444, missing
tab sw3v444 sw3v198, missing

** sw3v198 looks a better bet than sw3v148 as it accounts for non degree courses. Debatable however.


* Need to split those who aren't doing a degree into camps...

* Put in section from t3_nqf_a

* label variable t3degree "currently studying for degree"
* label define t3 degree1 0 "no, studying for a non-advanced qualification" 1 "yes, studying for a degree"

***

** 63) t3dooct

tab sw3v16, missing

gen t3dooct=.
replace t3dooct=1 if (sw3v16==5)
replace t3dooct=5 if (sw3v16==2 | sw3v16==3)
replace t3dooct=6 if (sw3v16==4)
replace t3dooct=8 if (sw3v16==1)
replace t3dooct=10 if (sw3v16==6)
tab t3dooct, missing

label define t3dooct1 ///
1 "full time education" ///
5 "government supported training" ///
6 "full time job" ///
7 "part-time job" ///
8 "unemployed" ///
9 "home or family" ///
10 "something else"
label values t3dooct t3dooct1
label variable t3dooct "activity in october 2.5 years after the end of compulsory education"
numlabel t3dooct1, add
tab t3dooct, missing

* missing is . not -9

***

** 64) t3donow

tab sw3v21, missing

gen t3donow=.
replace t3donow=1 if (sw3v21==4)
replace t3donow=5 if (sw3v21==3)
replace t3donow=6 if (sw3v21==2)
replace t3donow=7 if (sw3v21==7)
replace t3donow=8 if (sw3v21==1)
replace t3donow=9 if (sw3v21==5)
replace t3donow=10 if (sw3v21==6)
tab t3donow, missing

label define t3donow1 ///
1 "full time education" ///
5 "government supported training" ///
6 "full time job" ///
7 "part-time job" ///
8 "unemployed" ///
9 "home or family" ///
10 "something else"
label values t3donow t3donow1
label variable t3donow "activity in spring 3 years after the end of compulsory education"
numlabel t3donow1, add
tab t3donow, missing

***

** 65) t2dooct

tab sw2v16, missing

gen t2dooct=.
replace t2dooct=1 if (sw2v16==6)
replace t2dooct=5 if (sw2v16==2 | sw2v16==3 | sw2v16==4)
replace t2dooct=6 if (sw2v16==5)
replace t2dooct=8 if (sw2v16==1)
replace t2dooct=10 if (sw2v16==7)
tab t2dooct, missing

label define t2dooct1 ///
1 "full time education" ///
5 "government supported training" ///
6 "full time job" ///
7 "part-time job" ///
8 "unemployed" ///
9 "home or family" ///
10 "something else"
label values t2dooct t2dooct1
label variable t2dooct "activity in october 1.5 years after the end of compulsory education"
numlabel t2dooct1, add
tab t2dooct, missing

***

** 66) t2donow

tab sw2v21, missing

gen t2donow=.
replace t2donow=1 if (sw2v21==6)
replace t2donow=5 if (sw2v21==2 | sw2v21==3 | sw2v21==4)
replace t2donow=6 if (sw2v21==5)
replace t2donow=7 if (sw2v21==8)
replace t2donow=8 if (sw2v21==1)
replace t2donow=10 if (sw2v21==7)
tab t2donow, missing

label define t2donow1 ///
1 "full time education" ///
5 "government supported training" ///
6 "full time job" ///
7 "part-time job" ///
8 "unemployed" ///
9 "home or family" ///
10 "something else"
label values t2donow t2donow1
label variable t2donow "activity in spring 2 years after the end of compulsory education"
numlabel t2donow1, add
tab t2donow, missing

tab1 t1dooct t1donow t2dooct t2donow t3dooct t3donow, missing

***

* Harmonised variables file

duplicates report id
duplicates report t0caseid

drop sw*
drop id

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs6_background_vars.dta, replace

clear

* END * 

