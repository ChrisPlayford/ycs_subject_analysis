* 14th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS10 Preparation of raw GCSE subject information

* The location of the folder containing the YCS wave 6 data

* global path3 "A:\data\YCS_Cohort_10_Download\stata8_se\"

* Moved file to temporary location because network connection too slow

global path3 "C:\Users\cplayfor\Documents\temp\"
global path4 "A:\data\YCS_time_series\stata8\"

clear
set more off

* Select a subset of variables to work on (dataset is too large)

use ///
a1_1	 ///
a1_2	 ///
a1_3	 ///
a11_1a	 ///
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
a11_10a	 ///
a11_10b	 ///
a11_10c	 ///
a11_11a	 ///
a11_11b	 ///
a11_11c	 ///
a11_11d	 ///
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
using $path3\ycs10final.dta, clear

numlabel _all, add

* YCS10 Data Dictionary
* A:\data\YCS_Cohort_10_Download\mrdoc\allissue\ycs10final_UKDA_Data_Dictionary.docx

* YCS10 User Guide
* A:\data\YCS_Cohort_10_Download\mrdoc\pdf\4571userguide.pdf

***

* T0EXAMST - This variable already exists in the ew_core dataset

* Eleven standard GCSE subjects (variables a11_1a-all_11a)

tab a11_1a,  mi		/* 1  English (Language) */
tab a11_2a,  mi		/* 1  English (Literature) */
tab a11_3a,  mi		/* 2  Maths */
tab a11_4a,  mi		/* 5  French */
tab a11_5a,  mi		/* 4  Geography */
tab a11_6a,  mi		/* 3  History */
tab a11_7a,  mi		/* 16 Arts */
tab a11_8a,  mi		/* 6  CDT */
tab a11_9a,  mi		/* 14 Other Language (German) */
tab a11_10a, mi		/* 18 Other GCSE Subject (Business Studies) */
tab a11_11a, mi		/* 10 Combined Sciences 1 & 2 */

* Big loop to recode these and generate new variables

tokenize "1_1 1_2 2 5 4 3 16_1 6 14_1 18_1 10"

foreach x of var 	a11_1a ///
					a11_2a ///
					a11_3a ///
					a11_4a ///
					a11_5a ///
					a11_6a ///
					a11_7a ///
					a11_8a ///
					a11_9a ///
					a11_10a ///
					a11_11a ///
{
	recode `x' (1 = 1 "Studied") (2 = 0 "Did not study"), gen(t0gcst`1')
	mac shift
}

* Tried to harmonise with previous YCS cohorts but different subjects recorded as standard...

label variable t0gcst1_1   "Studied GCSE English Lang"
label variable t0gcst1_2   "Studied GCSE English Lit"

label variable t0gcst2     "Studied GCSE Maths"
label variable t0gcst3     "Studied GCSE History"
label variable t0gcst4     "Studied GCSE Geography"
label variable t0gcst5     "Studied GCSE French"
label variable t0gcst6     "Studied GCSE CDT"
label variable t0gcst10    "Studied GCSE Combined Sciences 1 & 2"

label variable t0gcst14_1  "Studied GCSE Other Language"
label variable t0gcst16_1  "Studied GCSE Arts"
label variable t0gcst18_1  "Studied GCSE Other GCSE Subject"

* Six GCSEs in other subjects (variables a11oga1-a11oga6)

* There is no summary variable - just a series of subjects studied for.

codebook 	a11oga1 ///			/* 11 Other GCSE subject 1 */
			a11oga2 ///			/* 12 Other GCSE subject 2 */
			a11oga3 ///			/* 13 Other GCSE subject 3 */
			a11oga4 ///			/* 14 Other GCSE subject 4 */
			a11oga5 ///			/* 15 Other GCSE subject 5 */
			a11oga6, compact	/* 16 Other GCSE subject 6 */

tab	a11oga1, mi	

* Big loop to recode these and generate new variables

tokenize "11 12 13 14 15 16"

foreach x of var 	a11oga1 ///
					a11oga2 ///
					a11oga3 ///
					a11oga4 ///
					a11oga5 ///
					a11oga6 ///
{
	recode `x' (1/278 = 1 "Studied") (-99.99 = 0 "Did not study"), gen(t0gcst`1')
	mac shift
}
			
label variable t0gcst11 "Studied Other GCSE subject 1"
label variable t0gcst12 "Studied Other GCSE subject 2"
label variable t0gcst13 "Studied Other GCSE subject 3"
label variable t0gcst14 "Studied Other GCSE subject 4"
label variable t0gcst15 "Studied Other GCSE subject 5"
label variable t0gcst16 "Studied Other GCSE subject 6"

* New variables indicating whether pupil studied for GCSE subject.

numlabel _all, add
tab1 t0gcst*, mi

* T0EXAMST - Variable counting number of exams studied for

egen t0examst = rowtotal(t0gcst*)
label variable t0examst "Number of GCSEs studied for"
mvdecode t0examst, mv(0)
mvencode t0examst, mv(-9)
tab t0examst, missing

* Check against the harmonised file version

* use $path4\ew_core.dta, clear
* tab t0examst if t0cohort==1999, mi
* Great - these are the same.

***

* T0EXAMAF T0EXAMAC T0SCORE - GCSE Grade variables
* 							- These variables already exist in the ew_core dataset

* Twelve standard GCSE subjects (variables a11_1c-all_11d)

tab a11_1c,  mi		/* 1  English (Language) */
tab a11_2c,  mi		/* 1  English (Literature) */
tab a11_3c,  mi		/* 2  Maths */
tab a11_4c,  mi		/* 5  French */
tab a11_5c,  mi		/* 4  Geography */
tab a11_6c,  mi		/* 3  History */
tab a11_7c,  mi		/* 16 Arts */
tab a11_8c,  mi		/* 6  CDT */
tab a11_9c,  mi		/* 14 Other Language (German) */
tab a11_10c, mi		/* 18 Other GCSE Subject (Business Studies) */
tab a11_11c, mi		/* 10 Combined Sciences 1 */
tab a11_11d, mi		/* 11 Combined Sciences 2 */

* The above is a bit of an anomaly re two science results but only 1 exam studied

* GCSE Other Subjects 1-6 - GCSE Grade variables

tab a11ogc1, mi		/* 12 GCSE Other Subject 1 */
tab a11ogc2, mi		/* 13 GCSE Other Subject 2 */
tab a11ogc3, mi		/* 14 GCSE Other Subject 3 */
tab a11ogc4, mi		/* 15 GCSE Other Subject 4 */
tab a11ogc5, mi		/* 16 GCSE Other Subject 5 */
tab a11ogc6, mi		/* 17 GCSE Other Subject 6 */

***

* Big Loop to construct GCSE Points Score Variable, A-F & A-C Indicators

tokenize "1_1 1_2 2 5 4 3 16_1 6 14_1 18_1 10 11 12 13 14 15 16 17"

set more off
foreach x of var 	a11_1c  ///
					a11_2c  ///
					a11_3c  ///
					a11_4c  ///
					a11_5c ///
					a11_6c ///
					a11_7c ///
					a11_8c ///
					a11_9c ///
					a11_10c ///
					a11_11c ///
					a11_11d ///
					a11ogc1 ///
					a11ogc2 ///
					a11ogc3 ///
					a11ogc4 ///
					a11ogc5 ///
					a11ogc6 ///
{
	clonevar t0gcres_raw`1' = `x'
	gen 	t0gcsc`1'=.									/* GCSE Points Score Variable */
	replace	t0gcsc`1'=7 if t0gcres_raw`1'==1
	replace	t0gcsc`1'=6 if t0gcres_raw`1'==2
	replace	t0gcsc`1'=5 if t0gcres_raw`1'==3
	replace	t0gcsc`1'=4 if t0gcres_raw`1'==4
	replace	t0gcsc`1'=3 if t0gcres_raw`1'==5
	replace	t0gcsc`1'=2 if t0gcres_raw`1'==6
	replace	t0gcsc`1'=1 if t0gcres_raw`1'==7
	replace	t0gcsc`1'=0 if t0gcres_raw`1'==8
	gen 	t0gcaf`1'=.									/* GCSE A-F Indicator (vs G/U) */
	replace	t0gcaf`1'=0 if t0gcsc`1'<2
	replace t0gcaf`1'=1 if t0gcsc`1'<. & t0gcsc`1'>1 
	gen		t0gcac`1'=.									/* GCSE A-C Indicator (vs D-U) */
	replace	t0gcac`1'=0 if t0gcsc`1'<5
	replace t0gcac`1'=1 if t0gcsc`1'<. & t0gcsc`1'>4
	gen		  t0gc`1'=.									/* GCSE A-C Indicator (coded 1/2) */
	replace	  t0gc`1'=1 if t0gcsc`1'<5
	replace   t0gc`1'=2 if t0gcsc`1'<. & t0gcsc`1'>4
	mac shift
}

* I have deliberately kept the U grade in the analysis.

***

* Label variables

label variable t0gcac1_1  "GCSE English Lang A-C"
label variable t0gcac1_2  "GCSE English Lit A-C"

label variable t0gcac2    "GCSE Maths A-C"
label variable t0gcac3    "GCSE History A-C"
label variable t0gcac4    "GCSE Geography A-C"
label variable t0gcac5    "GCSE French A-C"
label variable t0gcac6    "GCSE CDT A-C"
* label variable t0gcac7  "GCSE Biology A-C"
* label variable t0gcac8  "GCSE Physics A-C"
* label variable t0gcac9  "GCSE Chemistry A-C"
label variable t0gcac10   "GCSE Combined Science 1 A-C"
label variable t0gcac11   "GCSE Combined Science 2 A-C"

label variable t0gcac14_1 "GCSE Other Language A-C"
label variable t0gcac16_1 "GCSE Arts A-C"
label variable t0gcac18_1 "GCSE Other Subject A-C"

label variable t0gcac12 "GCSE Other Subject 1 A-C"
label variable t0gcac13 "GCSE Other Subject 2 A-C"
label variable t0gcac14 "GCSE Other Subject 3 A-C"
label variable t0gcac15 "GCSE Other Subject 4 A-C"
label variable t0gcac16 "GCSE Other Subject 5 A-C"
label variable t0gcac17 "GCSE Other Subject 6 A-C"

*

label variable t0gc1_1  "GCSE English Lang A-C"
label variable t0gc1_2  "GCSE English Lit A-C"

label variable t0gc2    "GCSE Maths A-C"
label variable t0gc3    "GCSE History A-C"
label variable t0gc4    "GCSE Geography A-C"
label variable t0gc5    "GCSE French A-C"
label variable t0gc6    "GCSE CDT A-C"
* label variable t0gc7  "GCSE Biology A-C"
* label variable t0gc8  "GCSE Physics A-C"
* label variable t0gc9  "GCSE Chemistry A-C"
label variable t0gc10   "GCSE Combined Science 1 A-C"
label variable t0gc11   "GCSE Combined Science 2 A-C"

label variable t0gc14_1 "GCSE Other Language A-C"
label variable t0gc16_1 "GCSE Arts A-C"
label variable t0gc18_1 "GCSE Other Subject A-C"

label variable t0gc12 "GCSE Other Subject 1 A-C"
label variable t0gc13 "GCSE Other Subject 2 A-C"
label variable t0gc14 "GCSE Other Subject 3 A-C"
label variable t0gc15 "GCSE Other Subject 4 A-C"
label variable t0gc16 "GCSE Other Subject 5 A-C"
label variable t0gc17 "GCSE Other Subject 6 A-C"

label define t0gc_ac ///
1 "D-U" ///
2 "A-C"

label values 	t0gc1_1  t0gc1_2  t0gc2    t0gc3   t0gc4  t0gc5 ///
				t0gc6                             t0gc10 t0gc11 ///
				t0gc14_1 t0gc16_1 t0gc18_1 ///
				t0gc12   t0gc13   t0gc14   t0gc15 t0gc16 t0gc17 ///
				t0gc_ac

*

label variable t0gcaf1_1  "GCSE English Lang A-F"
label variable t0gcaf1_2  "GCSE English Lit A-F"

label variable t0gcaf2    "GCSE Maths A-F"
label variable t0gcaf3    "GCSE History A-F"
label variable t0gcaf4    "GCSE Geography A-F"
label variable t0gcaf5    "GCSE French A-F"
label variable t0gcaf6    "GCSE CDT A-F"
* label variable t0gcaf7  "GCSE Biology A-F"
* label variable t0gcaf8  "GCSE Physics A-F"
* label variable t0gcaf9  "GCSE Chemistry A-F"
label variable t0gcaf10   "GCSE Combined Science 1 A-F"
label variable t0gcaf11   "GCSE Combined Science 2 A-F"

label variable t0gcaf14_1 "GCSE Other Language A-F"
label variable t0gcaf16_1 "GCSE Arts A-F"
label variable t0gcaf18_1 "GCSE Other Subject A-F"

label variable t0gcaf12 "GCSE Other Subject 1 A-F"
label variable t0gcaf13 "GCSE Other Subject 2 A-F"
label variable t0gcaf14 "GCSE Other Subject 3 A-F"
label variable t0gcaf15 "GCSE Other Subject 4 A-F"
label variable t0gcaf16 "GCSE Other Subject 5 A-F"
label variable t0gcaf17 "GCSE Other Subject 6 A-F"


*

label variable t0gcsc1_1  "GCSE English Lang Points Score"
label variable t0gcsc1_2  "GCSE English Lit Points Score"

label variable t0gcsc2    "GCSE Maths Points Score"
label variable t0gcsc3    "GCSE History Points Score"
label variable t0gcsc4    "GCSE Geography Points Score"
label variable t0gcsc5    "GCSE French Points Score"
label variable t0gcsc6    "GCSE CDT Points Score"
* label variable t0gcsc7  "GCSE Biology Points Score"
* label variable t0gcsc8  "GCSE Physics Points Score"
* label variable t0gcsc9  "GCSE Chemistry Points Score"
label variable t0gcsc10   "GCSE Combined Science 1 Points Score"
label variable t0gcsc11   "GCSE Combined Science 2 Points Score"

label variable t0gcsc14_1 "GCSE Other Language Points Score"
label variable t0gcsc16_1 "GCSE Arts Points Score"
label variable t0gcsc18_1 "GCSE Other Subject Points Score"

label variable t0gcsc12 "GCSE Other Subject 1 Points Score"
label variable t0gcsc13 "GCSE Other Subject 2 Points Score"
label variable t0gcsc14 "GCSE Other Subject 3 Points Score"
label variable t0gcsc15 "GCSE Other Subject 4 Points Score"
label variable t0gcsc16 "GCSE Other Subject 5 Points Score"
label variable t0gcsc17 "GCSE Other Subject 6 Points Score"

***

* Quality Assurance Checks

tab t0gcres_raw1_1 t0gcsc1_1, mi 
tab t0gcres_raw2 t0gcsc2, mi

tab t0gcres_raw1_1 t0gcaf1_1, mi 
tab t0gcres_raw2 t0gcaf2, mi

tab t0gcres_raw1_1 t0gcac1_1, mi 
tab t0gcres_raw2 t0gcac2, mi

tab t0gcac1_1 t0gc1_1, mi
tab t0gcac2 t0gc2, mi

***

* T0EXAMAF

egen t0examaf = rowtotal(t0gcaf*), missing
label variable t0examaf "num of A-F awards in Y11 or S4 exams"
replace t0examaf=. if t0examst==-9
mvencode t0examaf, mv(-9)
tab t0examaf, missing

* T0EXAMAC

egen t0examac = rowtotal(t0gcac*), missing
label variable t0examac "num of A-C awards in Y11 or S4 exams"
replace t0examac=. if t0examst==-9
mvencode t0examac, mv(-9)
tab t0examac, missing

* T0SCORE

egen t0score = rowtotal(t0gcsc*), missing
label variable t0score "point score from Y11 or S4 exams"
replace t0score=. if t0examst==-9
mvencode t0score, mv(-9)
tab t0score, missing

***

* Check against the harmonised file version

use $path4\ew_core.dta, clear
tab t0examaf if t0cohort==1999, mi
tab t0examac if t0cohort==1999, mi
tab t0score if t0cohort==1999, mi

* Almost the same - there is one case that differs
* Need 'missing' option on rowtotal.

***

* Investigating the absence of serial numbers from YCS10

/*
use $path3\ycs10final.dta, clear
lookfor serial
lookfor case
lookfor sn
lookfor ident
*/

use $path4\ew_core.dta, clear
tab t0cohort, mi

summarize t0caseid if t0cohort==1990
summarize t0caseid if t0cohort==1993
summarize t0caseid if t0cohort==1995
summarize t0caseid if t0cohort==1997
summarize t0caseid if t0cohort==1999

* YCS9

use $path4\ew_core.dta, clear
keep if t0cohort==1997
summarize t0caseid
codebook t0caseid
list t0caseid in 1/5

use serial using  "A:\data\YCS_Cohort_9_Download\stata8\ycs9sw1.dta", clear
summarize serial
codebook serial
list in 1/5

* YCS10

use $path4\ew_core.dta, clear
keep if t0cohort==1999
summarize t0caseid
codebook t0caseid
list t0caseid in 1/5

* It is not as simple as _n

* Stop work on this until it is resolved as 'serial' is essential to link the data

***

* Remaining tasks - recode the GCSEs taken in the Other GCSE variables
* Put into standard list of GCSEs
* Save dataset

clear

* END *
