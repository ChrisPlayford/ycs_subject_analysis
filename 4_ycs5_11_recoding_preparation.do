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
tab1 t0gc1eng english, missing

* Maths (manifest variable)

egen maths = anyvalue (t0gc2math), v(0/2)
tab1 t0gc2math maths, missing

* Science (manifest variable)

egen science = rmax (t0gc7bio t0gc8phy t0gc9che t0gc10sci t0gc12othsci)
tab science, missing

* Humanity (manifest variable)

egen humanity = rmax (t0gc3his t0gc4geo t0gc13othhum t0gc15re)
tab humanity, missing

* Other Subject (manifest variable)

egen othersub = rmax (t0gc5fre t0gc6cdt t0gc14othlan t0gc16arts t0gc17ped t0gc18other)
tab othersub, missing

***

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

* Creating marker variable indicating sample of interest.
						
mark sample if (t0schtyp==2 | t0schtyp==3)

markout sample		t0sex ///
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
tab sample, mi

* I will return to this dataset and code the dummy variables (as required).

***

* Save dataset

save $path3\ycs5_to_11_set4.dta, replace

clear

* END *
