* 15th December 2016

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS7 Preparation of raw GCSE subject information

* The location of the folder containing the YCS cohort 6 data

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
use $path7\cohort7.dta, clear
numlabel _all, add

* YCS7 Data Dictionary
* A:\data\YCS_Cohort_7_Download\mrdoc\allissue\cohort7_UKDA_Data_Dictionary.docx

* YCS7 User Guide
* A:\data\YCS_Cohort_7_Download\mrdoc\pdf\3533userguide.pdf

***

* T0EXAMST
* Creating indicators for subjects studied for

* Ten standard GCSE subjects (variables sw1v50-sw1v68)

tab sw1v50, missing		/* 1 English (Language) */
tab sw1v52, missing		/* 2 Maths */
tab sw1v54, missing		/* 3 History */
tab sw1v56, missing		/* 4 Geography */
tab sw1v58, missing		/* 5 French */
tab sw1v60, missing		/* 6 CDT */
tab sw1v62, missing		/* 7 Biology */
tab sw1v64, missing		/* 8 Physics */
tab sw1v66, missing		/* 9 Chemistry */
tab sw1v68, missing		/* 10 Combined Sciences 1 & 2 */

* They have only recorded the variable once for the exam
* They then record the exam results but they're different.
* I have to retain the data (even with problems such as these). One exam but two results...

* Eight GCSEs in other subjects (variables sw1v72-sw1v93)

tab sw1v72, missing		/* 11 Other GCSE subject 1 */
tab sw1v75, missing		/* 12 Other GCSE subject 2 */
tab sw1v78, missing		/* 13 Other GCSE subject 3 */
tab sw1v81, missing		/* 14 Other GCSE subject 4 */
tab sw1v84, missing		/* 15 Other GCSE subject 5 */
tab sw1v87, missing		/* 16 Other GCSE subject 6 */
tab sw1v90, missing		/* 17 Other GCSE subject 7 */
tab sw1v93, missing		/* 18 Other GCSE subject 8 */

***

* Big loop to recode these and generate new variables

tokenize "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18"

foreach x of var 	sw1v50 ///
					sw1v52 ///
					sw1v54 ///
					sw1v56 ///
					sw1v58 ///
					sw1v60 ///
					sw1v62 ///
					sw1v64 ///
					sw1v66 ///
					sw1v68 ///
					sw1v72 ///
					sw1v75 ///
					sw1v78 ///
					sw1v81 ///
					sw1v84 ///
					sw1v87 ///
					sw1v90 ///
					sw1v93 ///
{
	recode `x' (1/2 = 1 "Studied") (9 = 0 "Did not study"), gen(t0gcst`1')
	mac shift
}

* For useful info on this loop: http://www.stata.com/statalist/archive/2002-10/msg00374.html

label variable t0gcst1 "Studied GCSE English"
label variable t0gcst2 "Studied GCSE Maths"
label variable t0gcst3 "Studied GCSE History"
label variable t0gcst4 "Studied GCSE Geography"
label variable t0gcst5 "Studied GCSE French"

label variable t0gcst6 "Studied GCSE CDT"
label variable t0gcst7 "Studied GCSE Biology"
label variable t0gcst8 "Studied GCSE Physics"
label variable t0gcst9 "Studied GCSE Chemistry"
label variable t0gcst10 "Studied GCSE Combined Sciences 1 & 2"

label variable t0gcst11 "Studied Other GCSE subject 1"
label variable t0gcst12 "Studied Other GCSE subject 2"
label variable t0gcst13 "Studied Other GCSE subject 3"
label variable t0gcst14 "Studied Other GCSE subject 4"
label variable t0gcst15 "Studied Other GCSE subject 5"

label variable t0gcst16 "Studied Other GCSE subject 6"
label variable t0gcst17 "Studied Other GCSE subject 7"
label variable t0gcst18 "Studied Other GCSE subject 8"

* New variables indicating whether pupil studied for GCSE subject.

tab1 t0gcst*, mi

* T0EXAMST - Variable counting number of exams studied for

egen t0examst = rowtotal(t0gcst*)
label variable t0examst "Number of GCSEs studied for"
mvdecode t0examst, mv(0)
mvencode t0examst, mv(-9)
tab t0examst, missing

* Check against the harmonised file version

* global path4 "A:\data\YCS_time_series\stata8\"
* use $path4\ew_core.dta, clear
* tab t0examst if t0cohort==1993, mi
* Great - these are the same.

***

***

* T0EXAMAF T0EXAMAC T0SCORE - GCSE Grade variables

tab sw1v51, mi		/* 1 English */
tab sw1v53, mi 		/* 2 Maths */
tab sw1v55, mi		/* 3 History */
tab sw1v57, mi		/* 4 Geography */
tab sw1v59, mi		/* 5 French */
tab sw1v61, mi		/* 6 CDT */
tab sw1v63, mi 		/* 7 Biology */
tab sw1v65, mi		/* 8 Physics */
tab sw1v67, mi		/* 9 Chemistry */
tab sw1v69, mi		/* 10 Combined Science 1 */
tab sw1v70, mi		/* 11 Combined Science 2 */

* The above is a bit of an anomaly re two science results but only 1 exam studied

* GCSE Other Subjects 1-7 - GCSE Grade variables

tab sw1v73, mi		/* 12 GCSE Other Subject 1 */
tab sw1v76, mi		/* 13 GCSE Other Subject 2 */
tab sw1v79, mi		/* 14 GCSE Other Subject 3 */
tab sw1v82, mi		/* 15 GCSE Other Subject 4 */
tab sw1v85, mi		/* 16 GCSE Other Subject 5 */
tab sw1v88, mi		/* 17 GCSE Other Subject 6 */
tab sw1v91, mi		/* 18 GCSE Other Subject 7 */
tab sw1v94, mi		/* 19 GCSE Other Subject 8 */

***

* Big Loop to construct GCSE Points Score Variable, A-F & A-C Indicators

tokenize "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19"

set more off
foreach x of var 	sw1v51  ///
					sw1v53  ///
					sw1v55  ///
					sw1v57  ///
					sw1v59 ///
					sw1v61 ///
					sw1v63 ///
					sw1v65 ///
					sw1v67 ///
					sw1v69 ///
					sw1v70 ///
					sw1v73 ///
					sw1v76 ///
					sw1v79 ///
					sw1v82 ///
					sw1v85 ///
					sw1v88 ///
					sw1v91 ///
					sw1v94 ///
{
	clonevar t0gcres_raw`1' = `x'
	gen 	t0gcsc`1'=.									/* GCSE Points Score Variable */
	* rep	t0gcsc`1'=. if t0gcres_raw`1'=="8"
	* rep	t0gcsc`1'=. if t0gcres_raw`1'=="9"
	replace	t0gcsc`1'=7 if t0gcres_raw`1'=="A"
	replace	t0gcsc`1'=6 if t0gcres_raw`1'=="B"
	replace	t0gcsc`1'=5 if t0gcres_raw`1'=="C"
	replace	t0gcsc`1'=4 if t0gcres_raw`1'=="D"
	replace	t0gcsc`1'=3 if t0gcres_raw`1'=="E"
	replace	t0gcsc`1'=2 if t0gcres_raw`1'=="F"
	replace	t0gcsc`1'=1 if t0gcres_raw`1'=="G"
	replace	t0gcsc`1'=0 if t0gcres_raw`1'=="U"
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

label variable t0gcac1  "GCSE English A-C"
label variable t0gcac2  "GCSE Maths A-C"
label variable t0gcac3  "GCSE History A-C"
label variable t0gcac4  "GCSE Geography A-C"
label variable t0gcac5  "GCSE French A-C"

label variable t0gcac6  "GCSE CDT A-C"
label variable t0gcac7  "GCSE Biology A-C"
label variable t0gcac8  "GCSE Physics A-C"
label variable t0gcac9  "GCSE Chemistry A-C"
label variable t0gcac10 "GCSE Combined Science 1 A-C"

label variable t0gcac11 "GCSE Combined Science 2 A-C"
label variable t0gcac12 "GCSE Other Subject 1 A-C"
label variable t0gcac13 "GCSE Other Subject 2 A-C"
label variable t0gcac14 "GCSE Other Subject 3 A-C"
label variable t0gcac15 "GCSE Other Subject 4 A-C"

label variable t0gcac16 "GCSE Other Subject 5 A-C"
label variable t0gcac17 "GCSE Other Subject 6 A-C"
label variable t0gcac18 "GCSE Other Subject 7 A-C"
label variable t0gcac19 "GCSE Other Subject 8 A-C"

*

label variable t0gc1  "GCSE English A-C"
label variable t0gc2  "GCSE Maths A-C"
label variable t0gc3  "GCSE History A-C"
label variable t0gc4  "GCSE Geography A-C"
label variable t0gc5  "GCSE French A-C"

label variable t0gc6  "GCSE CDT A-C"
label variable t0gc7  "GCSE Biology A-C"
label variable t0gc8  "GCSE Physics A-C"
label variable t0gc9  "GCSE Chemistry A-C"
label variable t0gc10 "GCSE Combined Science 1 A-C"

label variable t0gc11 "GCSE Combined Science 2 A-C"
label variable t0gc12 "GCSE Other Subject 1 A-C"
label variable t0gc13 "GCSE Other Subject 2 A-C"
label variable t0gc14 "GCSE Other Subject 3 A-C"
label variable t0gc15 "GCSE Other Subject 4 A-C"

label variable t0gc16 "GCSE Other Subject 5 A-C"
label variable t0gc17 "GCSE Other Subject 6 A-C"
label variable t0gc18 "GCSE Other Subject 7 A-C"
label variable t0gc19 "GCSE Other Subject 8 A-C"

label define t0gc_ac ///
1 "D-U" ///
2 "A-C"

label values 	 t0gc1  t0gc2  t0gc3  t0gc4  t0gc5 ///
				 t0gc6  t0gc7  t0gc8  t0gc9 t0gc10 ///
				t0gc11 t0gc12 t0gc13 t0gc14 t0gc15 ///
				t0gc16 t0gc17 t0gc18 t0gc19 ///
				t0gc_ac

*

label variable t0gcaf1  "GCSE English A-F"
label variable t0gcaf2  "GCSE Maths A-F"
label variable t0gcaf3  "GCSE History A-F"
label variable t0gcaf4  "GCSE Geography A-F"
label variable t0gcaf5  "GCSE French A-F"

label variable t0gcaf6  "GCSE CDT A-F"
label variable t0gcaf7  "GCSE Biology A-F"
label variable t0gcaf8  "GCSE Physics A-F"
label variable t0gcaf9  "GCSE Chemistry A-F"
label variable t0gcaf10 "GCSE Combined Science 1 A-F"

label variable t0gcaf11 "GCSE Combined Science 2 A-F"
label variable t0gcaf12 "GCSE Other Subject 1 A-F"
label variable t0gcaf13 "GCSE Other Subject 2 A-F"
label variable t0gcaf14 "GCSE Other Subject 3 A-F"
label variable t0gcaf15 "GCSE Other Subject 4 A-F"

label variable t0gcaf16 "GCSE Other Subject 5 A-F"
label variable t0gcaf17 "GCSE Other Subject 6 A-F"
label variable t0gcaf18 "GCSE Other Subject 7 A-F"
label variable t0gcaf19 "GCSE Other Subject 8 A-F"

*

label variable t0gcsc1  "GCSE English Points Score"
label variable t0gcsc2  "GCSE Maths Points Score"
label variable t0gcsc3  "GCSE History Points Score"
label variable t0gcsc4  "GCSE Geography Points Score"
label variable t0gcsc5  "GCSE French Points Score"

label variable t0gcsc6  "GCSE CDT Points Score"
label variable t0gcsc7  "GCSE Biology Points Score"
label variable t0gcsc8  "GCSE Physics Points Score"
label variable t0gcsc9  "GCSE Chemistry Points Score"
label variable t0gcsc10 "GCSE Combined Science 1 Points Score"

label variable t0gcsc11 "GCSE Combined Science 2 Points Score"
label variable t0gcsc12 "GCSE Other Subject 1 Points Score"
label variable t0gcsc13 "GCSE Other Subject 2 Points Score"
label variable t0gcsc14 "GCSE Other Subject 3 Points Score"
label variable t0gcsc15 "GCSE Other Subject 4 Points Score"

label variable t0gcsc16 "GCSE Other Subject 5 Points Score"
label variable t0gcsc17 "GCSE Other Subject 6 Points Score"
label variable t0gcsc18 "GCSE Other Subject 7 Points Score"
label variable t0gcsc19 "GCSE Other Subject 8 Points Score"

***


* Quality Assurance Checks

tab t0gcres_raw1 t0gcsc1, mi 
tab t0gcres_raw2 t0gcsc2, mi

tab t0gcres_raw1 t0gcaf1, mi 
tab t0gcres_raw2 t0gcaf2, mi

tab t0gcres_raw1 t0gcac1, mi 
tab t0gcres_raw2 t0gcac2, mi

tab t0gcac1 t0gc1, mi
tab t0gcac2 t0gc2, mi

***

* T0EXAMAF

egen t0examaf = rowtotal(t0gcaf*)
label variable t0examaf "num of A-F awards in Y11 or S4 exams"
replace t0examaf=. if t0examst==-9
mvencode t0examaf, mv(-9)
tab t0examaf, missing

* T0EXAMAC

egen t0examac = rowtotal(t0gcac*)
label variable t0examac "num of A-C awards in Y11 or S4 exams"
replace t0examac=. if t0examst==-9
mvencode t0examac, mv(-9)
tab t0examac, missing

* T0SCORE

egen t0score = rowtotal(t0gcsc*)
label variable t0score "point score from Y11 or S4 exams"
replace t0score=. if t0examst==-9
mvencode t0score, mv(-9)
tab t0score, missing

***

* Check against the harmonised file version

* use $path4\ew_core.dta, clear
* tab t0examaf if t0cohort==1993, mi
* tab t0examac if t0cohort==1993, mi
* tab t0score if t0cohort==1993, mi

* All looks good

***

* The eight GCSEs in other subjects have variables indicating the subject taken
* The User Guide has details of the codes used

* 12 GCSE Other Subject 1 - sw1v71
* 13 GCSE Other Subject 2 - sw1v74
* 14 GCSE Other Subject 3 - sw1v77
* 15 GCSE Other Subject 4 - sw1v80
* 16 GCSE Other Subject 5 - sw1v83
* 17 GCSE Other Subject 6 - sw1v86
* 18 GCSE Other Subject 7 - sw1v89
* 19 GCSE Other Subject 8 - sw1v92

codebook sw1v71 sw1v74 sw1v77 sw1v80 sw1v83 sw1v86 sw1v89 sw1v92, compact

* This has the same coding scheme as YCS6

* Big loop to classify the huge number of GCSE subjects into 18 categories 

tokenize "12 13 14 15 16 17 18 19"
foreach x of var 	sw1v71 ///
					sw1v74 ///
					sw1v77 ///
					sw1v80 ///
					sw1v83 ///
					sw1v86 ///
					sw1v89 ///
					sw1v92 ///
{
	recode `x' ///
	(1           = 10 "Combined Science 1") ///
	(2 12/17 26  = 12 "Other science") ///
	(3/7         =  7 "Biology") ///
	(8/9         =  9 "Chemistry") ///
	(10/11       =  8 "Physics") ///
	(18/25       =  2 "Maths") ///
	(27/36       =  6 "CDT") ///
	(37          =  4 "Geography") ///
	(38/45 56/59 = 13 "Other humanity") ///
	(46/48       =  1 "English") ///
	(49          =  5 "French") ///
	(50/55       = 14 "Other languages") ///
	(60/61       =  3 "History") ///
	(62/63       = 15 "RE") ///
	(64/70       = 16 "Arts") ///
	(71/72       = 17 "PE") ///
	(73/79       = 18 "Other") ///
	(998/999     =  .) ///
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
label variable t0gc18sub "Other GCSE Subject 7"
label variable t0gc19sub "Other GCSE Subject 8"

* Quality Assurance Check

codebook sw1v71
count if sw1v71==998 | sw1v71==999
di 195 + 1576
numlabel _all, add
tab t0gc12sub, missing

***

* This next section takes each of the standard 18 subjects and ascertains the highest grade received for each.
* 	For example, the highest grade received for English 
* 	across the English variable and the 7 extra subject variables
*	e.g. English: highest grade received in t0gc1 or t0gc12-t0gc18 where t0gc12sub-t0gc18sub is English

tab t0gc1, mi	/* 1 English */
tab t0gc2, mi	/* 2 Maths */
tab t0gc3, mi	/* 3 History */
tab t0gc4, mi	/* 4 Geography */
tab t0gc5, mi	/* 5 French */
tab t0gc6, mi	/* 6 CDT */
tab t0gc7, mi	/* 7 Biology */
tab t0gc8, mi	/* 8 Physics */
tab t0gc9, mi	/* 9 Chemistry */

* This loop goes across all of these subjects and takes the maximum grade

set more off
forvalues j = 1(1)9 {
	capture drop temp12-temp19
	forvalues i = 12(1)19 {
		gen temp`i' = t0gc`i' if t0gc`i'sub==`j'
		}
		egen t0gc`j'_1 = rowmax(t0gc`j' temp12-temp19)
		drop temp12-temp19
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
(t0gc17sub==2 & t0gc17==0) | ///
(t0gc18sub==2 & t0gc18==0) | ///
(t0gc19sub==2 & t0gc19==0)

replace gc2math=1 if ///
t0gc2==1 | ///
(t0gc12sub==2 & t0gc12==1) | ///
(t0gc13sub==2 & t0gc13==1) | ///
(t0gc14sub==2 & t0gc14==1) | ///
(t0gc15sub==2 & t0gc15==1) | ///
(t0gc16sub==2 & t0gc16==1) | ///
(t0gc17sub==2 & t0gc17==1) | ///
(t0gc18sub==2 & t0gc18==1) | ///
(t0gc19sub==2 & t0gc19==1)

replace gc2math=2 if ///
t0gc2==2 | ///
(t0gc12sub==2 & t0gc12==2) | ///
(t0gc13sub==2 & t0gc13==2) | ///
(t0gc14sub==2 & t0gc14==2) | ///
(t0gc15sub==2 & t0gc15==2) | ///
(t0gc16sub==2 & t0gc16==2) | ///
(t0gc17sub==2 & t0gc17==2) | ///
(t0gc18sub==2 & t0gc18==2) | ///
(t0gc19sub==2 & t0gc19==2)

tab t0gc2_1 gc2math, missing
drop gc2math

***

* 10 Combined Science is a bit different (two grades)

tab1 t0gc10 t0gc11, mi

capture drop temp12-temp19
forvalues i = 12(1)19 {
	gen temp`i' = t0gc`i' if t0gc`i'sub==10
}

egen t0gc10_1 = rowmax(t0gc10 t0gc11 temp12-temp19)
drop temp12-temp19

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
(t0gc17sub==10 & t0gc17==0) | ///
(t0gc18sub==10 & t0gc18==0) | ///
(t0gc19sub==10 & t0gc19==0)

replace gc10sci=1 if ///
t0gc10==1 | ///
t0gc11==1 | ///
(t0gc12sub==10 & t0gc12==1) | ///
(t0gc13sub==10 & t0gc13==1) | ///
(t0gc14sub==10 & t0gc14==1) | ///
(t0gc15sub==10 & t0gc15==1) | ///
(t0gc16sub==10 & t0gc16==1) | ///
(t0gc17sub==10 & t0gc17==1) | ///
(t0gc18sub==10 & t0gc18==1) | ///
(t0gc19sub==10 & t0gc19==1)

replace gc10sci=2 if ///
t0gc10==2 | ///
t0gc11==2 | ///
(t0gc12sub==10 & t0gc12==2) | ///
(t0gc13sub==10 & t0gc13==2) | ///
(t0gc14sub==10 & t0gc14==2) | ///
(t0gc15sub==10 & t0gc15==2) | ///
(t0gc16sub==10 & t0gc16==2) | ///
(t0gc17sub==10 & t0gc17==2) | ///
(t0gc18sub==10 & t0gc18==2) | ///
(t0gc19sub==10 & t0gc19==2)

tab t0gc10_1 gc10sci, mi
drop gc10sci

***

* Remaining GCSE subjects - there are no "main" variables recording these
* All the information is from the 8 extra GCSE variables

* This loop goes across all of these subjects and takes the maximum grade

set more off
forvalues j = 12(1)18 {								/* Eighteen standard subjects */
	capture drop temp12-temp19
	forvalues i = 12(1)19 {							/* Variables 12-19 have info on 8 extra subjects */
		gen temp`i' = t0gc`i' if t0gc`i'sub==`j'
		}
		egen t0gc`j'_1 = rowmax(temp12-temp19)
		drop temp12-temp19
		}

* Quality Assurance Check - Other Science

gen gc12othsci=.
replace gc12othsci=0 if ///
(t0gc12sub==12 & t0gc12==0) | ///
(t0gc13sub==12 & t0gc13==0) | ///
(t0gc14sub==12 & t0gc14==0) | ///
(t0gc15sub==12 & t0gc15==0) | ///
(t0gc16sub==12 & t0gc16==0) | ///
(t0gc17sub==12 & t0gc17==0) | ///
(t0gc18sub==12 & t0gc18==0) | ///
(t0gc19sub==12 & t0gc19==0)

replace gc12othsci=1 if ///
(t0gc12sub==12 & t0gc12==1) | ///
(t0gc13sub==12 & t0gc13==1) | ///
(t0gc14sub==12 & t0gc14==1) | ///
(t0gc15sub==12 & t0gc15==1) | ///
(t0gc16sub==12 & t0gc16==1) | ///
(t0gc17sub==12 & t0gc17==1) | ///
(t0gc18sub==12 & t0gc18==1) | ///
(t0gc19sub==12 & t0gc19==1)

replace gc12othsci=2 if ///
(t0gc12sub==12 & t0gc12==2) | ///
(t0gc13sub==12 & t0gc13==2) | ///
(t0gc14sub==12 & t0gc14==2) | ///
(t0gc15sub==12 & t0gc15==2) | ///
(t0gc16sub==12 & t0gc16==2) | ///
(t0gc17sub==12 & t0gc17==2) | ///
(t0gc18sub==12 & t0gc18==2) | ///
(t0gc19sub==12 & t0gc19==2)

tab t0gc12_1 gc12othsci, missing
drop gc12othsci
		
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

tab1 t0gc1eng t0gc2math t0gc3his, mi

***

* HIGHEST GCSE SCORE

* This next section takes each of the standard 18 subjects and ascertains the highest score received for each.
* 	For example, the highest score received for English 
* 	across the English variable and the 7 extra subject variables
*	e.g. English: highest score received in t0gc1 or t0gc12-t0gc18 where t0gc12sub-t0gc18sub is English

tab t0gcsc1, mi		/* 1 English */
tab t0gcsc2, mi		/* 2 Maths */
tab t0gcsc3, mi		/* 3 History */
tab t0gcsc4, mi		/* 4 Geography */
tab t0gcsc5, mi		/* 5 French */
tab t0gcsc6, mi		/* 6 CDT */
tab t0gcsc7, mi		/* 7 Biology */
tab t0gcsc8, mi		/* 8 Physics */
tab t0gcsc9, mi		/* 9 Chemistry */

* This loop goes across all of these subjects and takes the maximum grade

set more off
forvalues j = 1(1)9 {
	capture drop temp12-temp19
	forvalues i = 12(1)19 {
		gen temp`i' = t0gcsc`i' if t0gc`i'sub==`j'
		}
		egen t0gcsc`j'_1 = rowmax(t0gcsc`j' temp12-temp19)
		drop temp12-temp19
		}

* Quality Assurance Check - Maths - Manual calculation

capture drop gc2math_sc
gen gc2math_sc=.
forval j = 0(1)7    {
		replace gc2math_sc=`j' if t0gcsc2==`j' | ///
		(t0gc12sub==2 & t0gcsc12==`j') | ///
		(t0gc13sub==2 & t0gcsc13==`j') | ///
		(t0gc14sub==2 & t0gcsc14==`j') | ///
		(t0gc15sub==2 & t0gcsc15==`j') | ///
		(t0gc16sub==2 & t0gcsc16==`j') | ///
		(t0gc17sub==2 & t0gcsc17==`j') | ///
		(t0gc18sub==2 & t0gcsc18==`j') | ///
		(t0gc19sub==2 & t0gcsc19==`j')
					}
tab gc2math_sc t0gcsc2_1, mi
drop gc2math_sc

***

* 10 Combined Science is a bit different (two grades)

tab1 t0gcsc10 t0gcsc11, mi

capture drop temp12-temp19
forvalues i = 12(1)19 {
	gen temp`i' = t0gcsc`i' if t0gc`i'sub==10
}

egen t0gcsc10_1 = rowmax(t0gcsc10 t0gcsc11 temp12-temp19)
drop temp12-temp19

tab t0gcsc10_1, mi

* Quality Assurance Check - Double Science - Manual calculation

capture drop gc10sci_sc
gen gc10sci_sc=.
forval j = 0(1)7    {
		replace gc10sci_sc=`j' if t0gcsc10==`j' | ///
								  t0gcsc11==`j' | ///
		(t0gc12sub==10 & t0gcsc12==`j') | ///
		(t0gc13sub==10 & t0gcsc13==`j') | ///
		(t0gc14sub==10 & t0gcsc14==`j') | ///
		(t0gc15sub==10 & t0gcsc15==`j') | ///
		(t0gc16sub==10 & t0gcsc16==`j') | ///
		(t0gc17sub==10 & t0gcsc17==`j') | ///
		(t0gc18sub==10 & t0gcsc18==`j') | ///
		(t0gc19sub==10 & t0gcsc19==`j')
					}
tab gc10sci_sc t0gcsc10_1, mi
drop gc10sci_sc

***

* Remaining GCSE subjects - there are no "main" variables recording these
* All the information is from the 7 extra GCSE variables

* This loop goes across all of these subjects and takes the maximum grade

set more off
forvalues j = 12(1)18 {								/* Eighteen standard subjects */
	capture drop temp12-temp19
	forvalues i = 12(1)19 {							/* Variables 12-19 have info on 8 extra subjects */
		gen temp`i' = t0gcsc`i' if t0gc`i'sub==`j'
		}
		egen t0gcsc`j'_1 = rowmax(temp12-temp19)
		drop temp12-temp19
		}

* Quality Assurance Check - Other Science

capture drop gc12othsci_sc
gen gc12othsci_sc=.
forval j = 0(1)7    {
		replace gc12othsci_sc=`j' if ///
		(t0gc12sub==12 & t0gcsc12==`j') | ///
		(t0gc13sub==12 & t0gcsc13==`j') | ///
		(t0gc14sub==12 & t0gcsc14==`j') | ///
		(t0gc15sub==12 & t0gcsc15==`j') | ///
		(t0gc16sub==12 & t0gcsc16==`j') | ///
		(t0gc17sub==12 & t0gcsc17==`j') | ///
		(t0gc18sub==12 & t0gcsc18==`j') | ///
		(t0gc19sub==12 & t0gcsc19==`j')
					}
tab t0gcsc12_1 gc12othsci, mi
drop gc12othsci

***

* Label and rename variables for ease of interpretation

rename  t0gcsc1_1 t0gc1eng_sc
rename  t0gcsc2_1 t0gc2math_sc
rename  t0gcsc3_1 t0gc3his_sc
rename  t0gcsc4_1 t0gc4geo_sc
rename  t0gcsc5_1 t0gc5fre_sc

rename  t0gcsc6_1 t0gc6cdt_sc
rename  t0gcsc7_1 t0gc7bio_sc
rename  t0gcsc8_1 t0gc8phy_sc
rename  t0gcsc9_1 t0gc9che_sc
rename t0gcsc10_1 t0gc10sci_sc

rename t0gcsc12_1 t0gc12othsci_sc
rename t0gcsc13_1 t0gc13othhum_sc
rename t0gcsc14_1 t0gc14othlan_sc
rename t0gcsc15_1 t0gc15re_sc

rename t0gcsc16_1 t0gc16arts_sc
rename t0gcsc17_1 t0gc17ped_sc
rename t0gcsc18_1 t0gc18other_sc

* Label variables

label variable t0gc1eng_sc 		"GCSE English Grade (highest score)"
label variable t0gc2math_sc 	"GCSE Maths Grade (highest score)"
label variable t0gc3his_sc 		"GCSE History Grade (highest score)"
label variable t0gc4geo_sc 		"GCSE Geography Grade (highest score)"
label variable t0gc5fre_sc 		"GCSE French Grade (highest score)"

label variable t0gc6cdt_sc 		"GCSE CDT Grade (highest score)"
label variable t0gc7bio_sc 		"GCSE Biology Grade (highest score)"
label variable t0gc8phy_sc 		"GCSE Physics Grade (highest score)"
label variable t0gc9che_sc 		"GCSE Chemistry Grade (highest score)"
label variable t0gc10sci_sc 	"GCSE Double Science Grade (highest score)"

label variable t0gc12othsci_sc 	"GCSE Other Science Grade (highest score)"
label variable t0gc13othhum_sc 	"GCSE Other Humanity Grade (highest score)"
label variable t0gc14othlan_sc 	"GCSE Other Language Grade (highest score)"
label variable t0gc15re_sc 		"GCSE RE Grade (highest score)"

label variable t0gc16arts_sc 	"GCSE Arts Grade (highest score)"
label variable t0gc17ped_sc 	"GCSE PE Grade (highest score)"
label variable t0gc18other_sc 	"GCSE Other Subject Grade (highest score)"

tab1 t0gc1eng_sc t0gc2math_sc t0gc3his_sc, mi

tab t0gc1eng_sc t0gc1eng, mi

***

* Rename the identifying variables

rename id t0caseid
gen t0cohort=1993
label variable t0cohort "year completed compulsory schooling"

drop sw*
order *, sequential
order t0cohort t0caseid t0examst t0examaf t0examac t0score
sort t0cohort t0caseid

codebook, compact

* Save the subjects dataset

global path3 "A:\YCS\github_ycs_subject_analysis\data\"
save $path3\ycs7_gsce_subjects.dta, replace

clear

* END * 
