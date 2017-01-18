* 10th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Recoding variables of interest and preparing dummy variables

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

**

* YCS 5-11 Dataset (includes class variables)

use $path3\ycs5_to_11_set3.dta, clear
numlabel _all, add

* Variables of interest

* Sex
* Ethnicity
* Housing
* Household Type

tab1 t0sex t0ethnic t0house t0stay, mi

mvdecode 	t0ethnic ///
			t0house ///
			t0stay, mv(-9)	/* Set to missing */

* NS-SEC / RGSC / CAMSIS

tab1 t0dad_nssec t0dad_rgsc, mi 
codebook t0dad_mcamsis

* Approximately 23,000 missing on Fathers' occupational information

tab1 t0mum_nssec t0mum_rgsc, mi 
codebook t0mum_mcamsis

* Approximately 33,000 missing on Mothers' occupational information

***

* Justification for using highest occupational position in household

egen t0par_nssec = rowmin(t0dad_nssec t0mum_nssec)
label variable t0par_nssec "Parental National Statistics Socio-Economic Classification (Reduced Form)"
tab1 t0dad_nssec t0mum_nssec t0par_nssec, mi

egen t0par_rgsc = rowmin(t0dad_rgsc t0mum_rgsc)
label variable t0par_rgsc "Parental Registrar-General's Social Class"
tab1 t0dad_rgsc t0mum_rgsc t0par_rgsc, mi

* Put CAMSIS on male scale

egen t0par_mcamsis = rowmin(t0dad_mcamsis t0mum_mcamsis)
label variable t0par_mcamsis "Parental (Male) CAMSIS score"
codebook t0dad_mcamsis t0mum_mcamsis t0par_mcamsis

* Change order of variables

order 	t0par_nssec ///
		t0par_rgsc ///
		t0par_mcamsis, ///
			after(t0mum_rgsc)

***

* Parental education variables

tab1 t0dadpce t0dadalv t0daddeg, mi
tab1 t0mumpce t0mumalv t0mumdeg, mi

mvdecode 	t0dadpce ///
			t0dadalv ///
			t0daddeg ///
			t0mumpce ///
			t0mumalv ///
			t0mumdeg, mv(-9)
			
* Large number of missing values
* Decision to be made about "Other Response" - unclear what this is.
			
***

* Identify only comprehensive school pupils

tab t0schtyp, missing

***

* Latent Classes

* In the first instance I will stick to the original five groupings

tab1 	t0gc1eng     t0gc2math    t0gc3his     t0gc4geo t0gc5fre ///
		t0gc6cdt     t0gc7bio     t0gc8phy     t0gc9che t0gc10sci ///
		t0gc12othsci t0gc13othhum t0gc14othlan t0gc15re ///
		t0gc16arts   t0gc17ped    t0gc18other, missing

* English (manifest variable)

egen english = anyvalue (t0gc1eng), v(0/2)
label variable english "Highest Grade in GCSE English subjects"
tab1 t0gc1eng english, missing

* Maths (manifest variable)

egen maths = anyvalue (t0gc2math), v(0/2)
label variable maths "Highest Grade in GCSE Maths subjects"
tab1 t0gc2math maths, missing

* Science (manifest variable)

egen science = rmax (t0gc7bio t0gc8phy t0gc9che t0gc10sci t0gc12othsci)
label variable science "Highest Grade in GCSE Science subjects"
tab science, missing

* Humanity (manifest variable)

egen humanity = rmax (t0gc3his t0gc4geo t0gc13othhum t0gc15re)
label variable humanity "Highest Grade in GCSE Humanity subjects"
tab humanity, missing

* Other Subject (manifest variable)

egen othersub = rmax (t0gc5fre t0gc6cdt t0gc14othlan t0gc16arts t0gc17ped t0gc18other)
label variable othersub "Highest Grade in GCSE Other subjects"
tab othersub, missing

***

* Alternative groupings

* I attempted this with Creative Arts as a grouping but over half of pupils don't study these.
* The resultant sample size is approx 24,000 which is a waste of information.

* Languages (manifest variable)

egen language = rmax (t0gc5fre t0gc14othlan)
label variable language "Highest Grade in GCSE Languages"
tab language, missing

* Other Subject 2 (manifest variable)

egen othersub2 = rmax (t0gc6cdt t0gc16arts t0gc17ped t0gc18other)
label variable othersub2 "Highest Grade in GCSE Other subjects (CDT, PE & Other)"
tab othersub, missing

***

* Sample definitions

* Identify likely sample size (comprehensive pupils only)

set more off
misstable patterns 	t0sex ///
					t0ethnic ///
					t0house ///
					t0stay ///
					t0par_nssec ///
					t0par_rgsc ///
					t0par_mcamsis ///
					english ///
					maths ///
					science ///
					humanity ///
					othersub ///
						if (t0schtyp==2 | t0schtyp==3), freq

* Sample for all available subject information

mark    sample1
markout sample1		english ///
					maths ///
					science ///
					humanity ///
					othersub

label variable sample1 "Sample - nonmissing GCSE subjects"
tab sample1, mi

* Sample for all available subject information (alternative grouping)

mark    sample2
markout sample2		english ///
					maths ///
					science ///
					humanity ///
					language ///
					othersub2

label variable sample2 "Sample - nonmissing GCSE subjects (alternative grouping)"
tab sample2, mi
						
* Creating marker variable indicating sample of interest - subjects & covariates.
						
mark sample3 if (t0schtyp==2 | t0schtyp==3)

markout sample3		t0sex ///
					t0ethnic ///
					t0house ///
					t0stay ///
					t0par_nssec ///
					t0par_rgsc ///
					t0par_mcamsis ///
					english ///
					maths ///
					science ///
					humanity ///
					othersub

label variable sample3 "Sample - nonmissing GCSE subjects & covariates"
tab sample3, mi

* Creating marker variable indicating sample of interest - alt subject grouping & covariates.
						
mark sample4 if (t0schtyp==2 | t0schtyp==3)

markout sample4		t0sex ///
					t0ethnic ///
					t0house ///
					t0stay ///
					t0par_nssec ///
					t0par_rgsc ///
					t0par_mcamsis ///
					english ///
					maths ///
					science ///
					humanity ///
					language ///
					othersub2

label variable sample4 "Sample - nonmissing GCSE subjects (alt grouping) & covariates"
tab sample4, mi

***

* Save dataset

save $path3\ycs5_to_11_set4.dta, replace

clear

* END *
