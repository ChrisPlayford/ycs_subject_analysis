* 14th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS10 Preparation of raw GCSE subject information

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

use $path10\ycs10final.dta, clear
* numlabel _all, add

* YCS10 Data Dictionary
* A:\data\YCS_Cohort_10_Download\mrdoc\allissue\ycs10final_UKDA_Data_Dictionary.docx

* YCS10 User Guide
* A:\data\YCS_Cohort_10_Download\mrdoc\pdf\4571userguide.pdf

***

* T0EXAMST - This variable already exists in the ew_core dataset

numlabel 	a11_1a ///
			a11_2a ///
			a11_3a ///
			a11_4a ///
			a11_5a ///
			a11_6a ///
			a11_7a ///
			a11_8a ///
			a11_9a ///
			a11_10a ///
			a11_11a, add

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

tokenize "1a 1b 2 5 4 3 16a 6 14a 18a 10"

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

label variable t0gcst1a    "Studied GCSE English Lang"
label variable t0gcst1b    "Studied GCSE English Lit"

label variable t0gcst2     "Studied GCSE Maths"
label variable t0gcst3     "Studied GCSE History"
label variable t0gcst4     "Studied GCSE Geography"
label variable t0gcst5     "Studied GCSE French"
label variable t0gcst6     "Studied GCSE CDT"
label variable t0gcst10    "Studied GCSE Combined Sciences 1 & 2"

label variable t0gcst14a   "Studied GCSE Other Language"
label variable t0gcst16a   "Studied GCSE Arts"
label variable t0gcst18a   "Studied GCSE Other GCSE Subject"

* Six GCSEs in other subjects (variables a11oga1-a11oga6)

* There is no summary variable - just a series of subjects studied for.

codebook 	a11oga1 ///			/* 11 Other GCSE subject 1 */
			a11oga2 ///			/* 12 Other GCSE subject 2 */
			a11oga3 ///			/* 13 Other GCSE subject 3 */
			a11oga4 ///			/* 14 Other GCSE subject 4 */
			a11oga5 ///			/* 15 Other GCSE subject 5 */
			a11oga6, compact	/* 16 Other GCSE subject 6 */

numlabel a11oga1, add
set more off
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

* numlabel _all, add
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

tokenize "1a 1b 2 5 4 3 16a 6 14a 18a 10 11 12 13 14 15 16 17"

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

label variable t0gcac1a   "GCSE English Lang A-C"
label variable t0gcac1b   "GCSE English Lit A-C"

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

label variable t0gcac14a  "GCSE Other Language A-C"
label variable t0gcac16a  "GCSE Arts A-C"
label variable t0gcac18a  "GCSE Other Subject A-C"

label variable t0gcac12   "GCSE Other Subject 1 A-C"
label variable t0gcac13   "GCSE Other Subject 2 A-C"
label variable t0gcac14   "GCSE Other Subject 3 A-C"
label variable t0gcac15   "GCSE Other Subject 4 A-C"
label variable t0gcac16   "GCSE Other Subject 5 A-C"
label variable t0gcac17   "GCSE Other Subject 6 A-C"

*

label variable t0gc1a   "GCSE English Lang A-C"
label variable t0gc1b   "GCSE English Lit A-C"

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

label variable t0gc14a  "GCSE Other Language A-C"
label variable t0gc16a  "GCSE Arts A-C"
label variable t0gc18a  "GCSE Other Subject A-C"

label variable t0gc12   "GCSE Other Subject 1 A-C"
label variable t0gc13   "GCSE Other Subject 2 A-C"
label variable t0gc14   "GCSE Other Subject 3 A-C"
label variable t0gc15   "GCSE Other Subject 4 A-C"
label variable t0gc16   "GCSE Other Subject 5 A-C"
label variable t0gc17   "GCSE Other Subject 6 A-C"

label define t0gc_ac ///
1 "D-U" ///
2 "A-C"

label values 	t0gc1a   t0gc1b   t0gc2    t0gc3   t0gc4  t0gc5 ///
				t0gc6                             t0gc10 t0gc11 ///
				t0gc14a  t0gc16a  t0gc18a  ///
				t0gc12   t0gc13   t0gc14   t0gc15 t0gc16 t0gc17 ///
				t0gc_ac

*

label variable t0gcaf1a   "GCSE English Lang A-F"
label variable t0gcaf1b   "GCSE English Lit A-F"

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

label variable t0gcaf14a  "GCSE Other Language A-F"
label variable t0gcaf16a  "GCSE Arts A-F"
label variable t0gcaf18a  "GCSE Other Subject A-F"

label variable t0gcaf12   "GCSE Other Subject 1 A-F"
label variable t0gcaf13   "GCSE Other Subject 2 A-F"
label variable t0gcaf14   "GCSE Other Subject 3 A-F"
label variable t0gcaf15   "GCSE Other Subject 4 A-F"
label variable t0gcaf16   "GCSE Other Subject 5 A-F"
label variable t0gcaf17   "GCSE Other Subject 6 A-F"


*

label variable t0gcsc1a   "GCSE English Lang Points Score"
label variable t0gcsc1b   "GCSE English Lit Points Score"

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

label variable t0gcsc14a  "GCSE Other Language Points Score"
label variable t0gcsc16a  "GCSE Arts Points Score"
label variable t0gcsc18a  "GCSE Other Subject Points Score"

label variable t0gcsc12   "GCSE Other Subject 1 Points Score"
label variable t0gcsc13   "GCSE Other Subject 2 Points Score"
label variable t0gcsc14   "GCSE Other Subject 3 Points Score"
label variable t0gcsc15   "GCSE Other Subject 4 Points Score"
label variable t0gcsc16   "GCSE Other Subject 5 Points Score"
label variable t0gcsc17   "GCSE Other Subject 6 Points Score"

***

* Quality Assurance Checks

tab t0gcres_raw1a t0gcsc1a, mi 
tab t0gcres_raw2 t0gcsc2, mi

tab t0gcres_raw1a t0gcaf1a, mi 
tab t0gcres_raw2 t0gcaf2, mi

tab t0gcres_raw1a t0gcac1a, mi 
tab t0gcres_raw2 t0gcac2, mi

tab t0gcac1a t0gc1a, mi
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

* use $path4\ew_core.dta, clear
* tab t0examaf if t0cohort==1999, mi
* tab t0examac if t0cohort==1999, mi
* tab t0score if t0cohort==1999, mi

* Almost the same - there is one case that differs
* Need 'missing' option on rowtotal.

***

* The six GCSEs in other subjects have variables indicating the subject taken
* The User Guide has details of the codes used

codebook 	a11oga1 ///			/* 12 Other GCSE subject 1 */
			a11oga2 ///			/* 13 Other GCSE subject 2 */
			a11oga3 ///			/* 14 Other GCSE subject 3 */
			a11oga4 ///			/* 15 Other GCSE subject 4 */
			a11oga5 ///			/* 16 Other GCSE subject 5 */
			a11oga6, compact	/* 17 Other GCSE subject 9 */
			
* These codes are different to previous YCS cohorts. See User Guide.
* They are completely different from YCS9.

* Big loop to classify the huge number of GCSE subjects into 18 categories 

tokenize "12 13 14 15 16 17"
foreach x of var 	a11oga1 ///
					a11oga2 ///
					a11oga3 ///
					a11oga4 ///
					a11oga5 ///
					a11oga6 ///
{
	recode `x' ///
	(8/11								= 10 "Combined Science 1") ///
	(7 12/33 47/50 224					= 12 "Other science") ///
	(1/4								=  7 "Biology") ///
	(5									=  9 "Chemistry") ///
	(6									=  8 "Physics") ///
	(34/46								=  2 "Maths") ///
	(51/78 204/223 239/258 269/277		=  6 "CDT") ///
	(93/96								=  4 "Geography") ///
	(98/112	114/126	167/174				= 13 "Other humanity") ///
	(127/131							=  1 "English") ///
	(148								=  5 "French") ///
	(142/147 149/166					= 14 "Other languages") ///
	(97									=  3 "History") ///
	(113								= 15 "RE") ///
	(79/92 132/141 175/181				= 16 "Arts") ///
	(182/184							= 17 "PE") ///
	(185/203 225/238 259/268 278		= 18 "Other") ///
	(998/999 -99.99						=  .) ///
										, gen(t0gc`1'sub)
	mac shift
}


* Variable labels

label variable t0gc12sub "Other GCSE Subject 1"
label variable t0gc13sub "Other GCSE Subject 2"
label variable t0gc14sub "Other GCSE Subject 3"
label variable t0gc15sub "Other GCSE Subject 4"
label variable t0gc16sub "Other GCSE Subject 5"
label variable t0gc17sub "Other GCSE Subject 6"

* Quality Assurance Check

codebook a11oga1
count if a11oga1==-99.99 | a11oga1==365 | a11oga1==366
numlabel t0gc12sub, add
tab1 t0gc12sub t0gc13sub, missing

***

* This next section takes each of the standard 18 subjects and ascertains the highest grade received for each.
* 	For example, the highest grade received for Maths 
* 	across the Maths variable and the 8 extra subject variables
*	e.g. Maths: highest grade received in t0gc2 or t0gc12-t0gc19 where t0gc12sub-t0gc18sub is Maths

* 1 English is different because there are two grades

tab t0gc1a, mi	/* 1 English Language */
tab t0gc1b, mi	/* 1 English Literature */

capture drop temp12-temp17
forvalues i = 12(1)17 {
	gen temp`i' = t0gc`i' if t0gc`i'sub==1
}

egen t0gc1_1 = rowmax(t0gc1a t0gc1b temp12-temp17)
drop temp12-temp17

tab t0gc1_1, mi

* Quality Assurance Check - Combined Science

gen gc1eng=.
replace gc1eng=0 if ///
t0gc1a==0 | ///
t0gc1b==0 | ///
(t0gc12sub==1 & t0gc12==0) | ///
(t0gc13sub==1 & t0gc13==0) | ///
(t0gc14sub==1 & t0gc14==0) | ///
(t0gc15sub==1 & t0gc15==0) | ///
(t0gc16sub==1 & t0gc16==0) | ///
(t0gc17sub==1 & t0gc17==0)

replace gc1eng=1 if ///
t0gc1a==1 | ///
t0gc1b==1 | ///
(t0gc12sub==1 & t0gc12==1) | ///
(t0gc13sub==1 & t0gc13==1) | ///
(t0gc14sub==1 & t0gc14==1) | ///
(t0gc15sub==1 & t0gc15==1) | ///
(t0gc16sub==1 & t0gc16==1) | ///
(t0gc17sub==1 & t0gc17==1)

replace gc1eng=2 if ///
t0gc1a==2 | ///
t0gc1b==2 | ///
(t0gc12sub==1 & t0gc12==2) | ///
(t0gc13sub==1 & t0gc13==2) | ///
(t0gc14sub==1 & t0gc14==2) | ///
(t0gc15sub==1 & t0gc15==2) | ///
(t0gc16sub==1 & t0gc16==2) | ///
(t0gc17sub==1 & t0gc17==2)

tab t0gc1_1 gc1eng, mi
drop gc1eng

***

* 10 Combined Science is also a bit different (two grades)

tab1 t0gc10 t0gc11, mi

capture drop temp12-temp17
forvalues i = 12(1)17 {
	gen temp`i' = t0gc`i' if t0gc`i'sub==10
}

egen t0gc10_1 = rowmax(t0gc10 t0gc11 temp12-temp17)
drop temp12-temp17

tab t0gc10_1, mi

* Quality Assurance Check - Combined Science

gen gc10sci=.
replace gc10sci=0 if ///
t0gc10==0 | ///
t0gc11==0 | ///
(t0gc12sub==10 & t0gc12==0) | ///
(t0gc13sub==10 & t0gc13==0) | ///
(t0gc14sub==10 & t0gc14==0) | ///
(t0gc15sub==10 & t0gc15==0) | ///
(t0gc16sub==10 & t0gc16==0) | ///
(t0gc17sub==10 & t0gc17==0)

replace gc10sci=1 if ///
t0gc10==1 | ///
t0gc11==1 | ///
(t0gc12sub==10 & t0gc12==1) | ///
(t0gc13sub==10 & t0gc13==1) | ///
(t0gc14sub==10 & t0gc14==1) | ///
(t0gc15sub==10 & t0gc15==1) | ///
(t0gc16sub==10 & t0gc16==1) | ///
(t0gc17sub==10 & t0gc17==1)

replace gc10sci=2 if ///
t0gc10==2 | ///
t0gc11==2 | ///
(t0gc12sub==10 & t0gc12==2) | ///
(t0gc13sub==10 & t0gc13==2) | ///
(t0gc14sub==10 & t0gc14==2) | ///
(t0gc15sub==10 & t0gc15==2) | ///
(t0gc16sub==10 & t0gc16==2) | ///
(t0gc17sub==10 & t0gc17==2)

tab t0gc10_1 gc10sci, mi
drop gc10sci

***

* Standard subjects common with previous YCS cohorts

tab t0gc2, mi	/* 2 Maths */
tab t0gc3, mi	/* 3 History */
tab t0gc4, mi	/* 4 Geography */
tab t0gc5, mi	/* 5 French */
tab t0gc6, mi	/* 6 CDT */

* This loop goes across all of these subjects and takes the maximum grade

set more off
forvalues j = 2(1)6 {
	capture drop temp12-temp17
	forvalues i = 12(1)17 {
		gen temp`i' = t0gc`i' if t0gc`i'sub==`j'
		}
		egen t0gc`j'_1 = rowmax(t0gc`j' temp12-temp17)
		drop temp12-temp17
		}

* Quality Assurance Check - Maths - Manual calculation

tab t0gc2_1, mi

gen gc2math=.
replace gc2math=0 if ///
t0gc2==0 | ///
(t0gc12sub==2 & t0gc12==0) | ///
(t0gc13sub==2 & t0gc13==0) | ///
(t0gc14sub==2 & t0gc14==0) | ///
(t0gc15sub==2 & t0gc15==0) | ///
(t0gc16sub==2 & t0gc16==0) | ///
(t0gc17sub==2 & t0gc17==0)

replace gc2math=1 if ///
t0gc2==1 | ///
(t0gc12sub==2 & t0gc12==1) | ///
(t0gc13sub==2 & t0gc13==1) | ///
(t0gc14sub==2 & t0gc14==1) | ///
(t0gc15sub==2 & t0gc15==1) | ///
(t0gc16sub==2 & t0gc16==1) | ///
(t0gc17sub==2 & t0gc17==1)

replace gc2math=2 if ///
t0gc2==2 | ///
(t0gc12sub==2 & t0gc12==2) | ///
(t0gc13sub==2 & t0gc13==2) | ///
(t0gc14sub==2 & t0gc14==2) | ///
(t0gc15sub==2 & t0gc15==2) | ///
(t0gc16sub==2 & t0gc16==2) | ///
(t0gc17sub==2 & t0gc17==2)

tab t0gc2_1 gc2math, missing
drop gc2math

***

* In YCS10, Biology, Chemistry and Physics are not standard subjects.
* They need to be treated the same as the additional subjects (non-standard)
* There are no "main" variables recording these
* All the information is from the 8 extra GCSE variables

* This loop goes across all of these subjects and takes the maximum grade

set more off
foreach j of numlist 7 8 9 12 13 15 17 {			/* Bio, Phys, Chem and other subjects */
	capture drop temp12-temp17
	forvalues i = 12(1)17 {							/* Variables 12-19 have info on 8 extra subjects */
		gen temp`i' = t0gc`i' if t0gc`i'sub==`j'
		}
		egen t0gc`j'_1 = rowmax(temp12-temp17)
		drop temp12-temp17
		}

* Quality Assurance Check - Other Science

gen gc12othsci=.
replace gc12othsci=0 if ///
(t0gc12sub==12 & t0gc12==0) | ///
(t0gc13sub==12 & t0gc13==0) | ///
(t0gc14sub==12 & t0gc14==0) | ///
(t0gc15sub==12 & t0gc15==0) | ///
(t0gc16sub==12 & t0gc16==0) | ///
(t0gc17sub==12 & t0gc17==0)

replace gc12othsci=1 if ///
(t0gc12sub==12 & t0gc12==1) | ///
(t0gc13sub==12 & t0gc13==1) | ///
(t0gc14sub==12 & t0gc14==1) | ///
(t0gc15sub==12 & t0gc15==1) | ///
(t0gc16sub==12 & t0gc16==1) | ///
(t0gc17sub==12 & t0gc17==1)

replace gc12othsci=2 if ///
(t0gc12sub==12 & t0gc12==2) | ///
(t0gc13sub==12 & t0gc13==2) | ///
(t0gc14sub==12 & t0gc14==2) | ///
(t0gc15sub==12 & t0gc15==2) | ///
(t0gc16sub==12 & t0gc16==2) | ///
(t0gc17sub==12 & t0gc17==2)

tab t0gc12_1 gc12othsci, missing
drop gc12othsci
		
***

* The last part is the subjects that were not standard in earlier YCS cohorts but are in YCS8.

tab1 t0gc14a t0gc16a t0gc18a, mi

* This loop goes across all of these subjects and takes the maximum grade

set more off
foreach j of numlist 14 16 18 {						/* Other Language, Arts, Other Subj (Bus Studies) */
	capture drop temp12-temp17
	forvalues i = 12(1)17 {							/* Variables 12-19 have info on 8 extra subjects */
		gen temp`i' = t0gc`i' if t0gc`i'sub==`j'
		}
		egen t0gc`j'_1 = rowmax(t0gc`j'a temp12-temp17)
		drop temp12-temp17
		}

* Quality Assurance Check - Other Language

gen gc14othlan=.
replace gc14othlan=0 if ///
t0gc14a==0 | ///
(t0gc12sub==14 & t0gc12==0) | ///
(t0gc13sub==14 & t0gc13==0) | ///
(t0gc14sub==14 & t0gc14==0) | ///
(t0gc15sub==14 & t0gc15==0) | ///
(t0gc16sub==14 & t0gc16==0) | ///
(t0gc17sub==14 & t0gc17==0)

replace gc14othlan=1 if ///
t0gc14a==1 | ///
(t0gc12sub==14 & t0gc12==1) | ///
(t0gc13sub==14 & t0gc13==1) | ///
(t0gc14sub==14 & t0gc14==1) | ///
(t0gc15sub==14 & t0gc15==1) | ///
(t0gc16sub==14 & t0gc16==1) | ///
(t0gc17sub==14 & t0gc17==1)

replace gc14othlan=2 if ///
t0gc14a==2 | ///
(t0gc12sub==14 & t0gc12==2) | ///
(t0gc13sub==14 & t0gc13==2) | ///
(t0gc14sub==14 & t0gc14==2) | ///
(t0gc15sub==14 & t0gc15==2) | ///
(t0gc16sub==14 & t0gc16==2) | ///
(t0gc17sub==14 & t0gc17==2)

tab t0gc14_1 gc14othlan, missing
drop gc14othlan

***

* Label and rename variables for ease of interpretation

label values 	 t0gc1_1  t0gc2_1  t0gc3_1  t0gc4_1  t0gc5_1 ///
				 t0gc6_1  t0gc7_1  t0gc8_1  t0gc9_1 t0gc10_1 ///
				         t0gc12_1 t0gc13_1 t0gc14_1 t0gc15_1 ///
				t0gc16_1 t0gc17_1 t0gc18_1 ///
				t0gc_ac

rename  t0gc1_1 t0gc1eng
rename  t0gc2_1 t0gc2math
rename  t0gc3_1 t0gc3his
rename  t0gc4_1 t0gc4geo
rename  t0gc5_1 t0gc5fre

rename  t0gc6_1 t0gc6cdt
rename  t0gc7_1 t0gc7bio
rename  t0gc8_1 t0gc8phy
rename  t0gc9_1 t0gc9che
rename t0gc10_1 t0gc10sci

rename t0gc12_1 t0gc12othsci
rename t0gc13_1 t0gc13othhum
rename t0gc14_1 t0gc14othlan
rename t0gc15_1 t0gc15re

rename t0gc16_1 t0gc16arts
rename t0gc17_1 t0gc17ped
rename t0gc18_1 t0gc18other

* Label variables

label variable t0gc1eng 	"GCSE English Grade (highest)"
label variable t0gc2math 	"GCSE Maths Grade (highest)"
label variable t0gc3his 	"GCSE History Grade (highest)"
label variable t0gc4geo 	"GCSE Geography Grade (highest)"
label variable t0gc5fre 	"GCSE French Grade (highest)"

label variable t0gc6cdt 	"GCSE CDT Grade (highest)"
label variable t0gc7bio 	"GCSE Biology Grade (highest)"
label variable t0gc8phy 	"GCSE Physics Grade (highest)"
label variable t0gc9che 	"GCSE Chemistry Grade (highest)"
label variable t0gc10sci 	"GCSE Double Science Grade (highest)"

label variable t0gc12othsci "GCSE Other Science Grade (highest)"
label variable t0gc13othhum "GCSE Other Humanity Grade (highest)"
label variable t0gc14othlan "GCSE Other Language Grade (highest)"
label variable t0gc15re 	"GCSE RE Grade (highest)"

label variable t0gc16arts 	"GCSE Arts Grade (highest)"
label variable t0gc17ped 	"GCSE PE Grade (highest)"
label variable t0gc18other 	"GCSE Other Subject Grade (highest)"

tab1 t0gc7bio t0gc8phy t0gc9che, mi

***

* Rename the identifying variables

* rename serial t0caseid /* THIS NEEDS TO BE ADDRESSED - NO SERIAL... */
gen t0cohort=1999
label variable t0cohort "year completed compulsory schooling"

keep t0*
order *, sequential
order t0cohort t0examst t0examaf t0examac t0score
* sort t0cohort t0caseid

codebook, compact

* Save the subjects dataset

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs10_gsce_subjects.dta, replace

clear

* END * 


