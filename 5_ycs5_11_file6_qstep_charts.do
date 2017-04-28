* 22nd March 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* Replication of YCS6 work using YCS5-YCS11

* Some additional charts for Q-step talk on the 27th April 2017

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

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, remove

set more off
estimates clear
capture matrix drop _all

svy: tab t03cat    t0cohort if sample3==1, col

* Graph of the above

set scheme s2color

graph hbar (count) [pweight=t1weight] if sample3==1, ///
			over(t03cat) ///
			over(t0cohort) ///
			percent stack asyvars ///
			graphregion(color(white)) ///
			legend(col(1)) ///
			ytitle("Percentage" " ") ///
			title("Percentage of young people" "gaining GCSE A*-C passes" " ") ///
			note(" " "All pupils gaining a GCSE pass at grades A-G, n=67,937, weighted data, YCS Cohorts 5-11")

graph export "A:\YCS\github_ycs_subject_analysis\outputs\qstep_chart_percentage_passes_20170405_cp_v1.wmf", replace as(wmf)
			
clear

***

* Model comparison

clear
input sample	n	var	class1	class2	class3	class4
1	92082	1	0.18328562	0.0739366	0.19227049	0.55050729
1	92082	2	0.17053877	0.48206236	0.84774609	0.9882804
1	92082	3	0.04242366	0.58817831	0.26652288	0.94480455
1	92082	4	0.0476433	0.79475249	0.23218868	0.95410343
1	92082	5	0.06984863	0.41385842	0.5367882	0.95504283
1	92082	6	0.29683897	0.64436949	0.77403103	0.96605725
3	67937	1	0.19404149	0.0828906	0.20525025	0.51781766
3	67937	2	0.17843518	0.49101741	0.85186851	0.9855928
3	67937	3	0.04374781	0.59744169	0.264742	0.93190052
3	67937	4	0.05088038	0.78606879	0.22674231	0.94709773
3	67937	5	0.07273939	0.42568608	0.54070442	0.94889892
3	67937	6	0.29666264	0.63956627	0.77606721	0.96017723
2	67863	1	0.16942356	0.12159101	0.17670045	0.53228498
2	67863	2	0.2443498	0.72726019	0.89130654	0.99847926
2	67863	3	0.06175641	0.71151322	0.30381837	0.96216223
2	67863	4	0.07285043	0.85759268	0.26111563	0.96462975
2	67863	5	0.07793373	0.59864098	0.58929204	0.9718275
2	67863	6	0.06925637	0.29126291	0.37180851	0.877483
2	67863	7	0.3193995	0.68002632	0.76724288	0.94769536
4	51446	1	0.17656554	0.14406514	0.17619091	0.5031784
4	51446	2	0.25086751	0.7319898	0.90173758	0.99779316
4	51446	3	0.06169626	0.70119206	0.27941617	0.95462524
4	51446	4	0.07488803	0.81326228	0.25113581	0.95960454
4	51446	5	0.0810341	0.60234229	0.59049588	0.9696234
4	51446	6	0.06335976	0.28241187	0.36483808	0.85628907
4	51446	7	0.3177968	0.67955253	0.77429785	0.94223677
end

keep if sample==1 | sample==3

list

* Labels

label define varlab ///
1 "Latent Class Prob" ///
2 "English A*-C" ///
3 "Maths A*-C" ///
4 "Science A*-C" ///
5 "Humanity A*-C" ///
6 "Other Sub A*-C" ///

label values var varlab

label define sample1 ///
1 "All subject info,  n=92,082" ///
3 "Plus covariates, n=67,937"

label values sample sample1

* Poor Grades

graph bar class1, 	over(sample, label(alternate labsize(vsmall)) ) ///
					over(var, label(alternate)) ///
					asyvars ///
					legend(cols(1)) ///
					title("Probabilities for Poor Grades Latent Class") ///
					ytitle("Probability") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_comp1_poor_grades_20170411_cp_v1.wmf", replace as(wmf)
					
* Science

graph bar class2, 	over(sample, label(alternate labsize(vsmall)) ) ///
					over(var, label(alternate)) ///
					asyvars ///
					legend(cols(1)) ///
					title("Probabilities for Science Latent Class") ///
					ytitle("Probability") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_comp1_science_20170411_cp_v1.wmf", replace as(wmf)
					
* Non-Science

graph bar class3, 	over(sample, label(alternate labsize(vsmall)) ) ///
					over(var, label(alternate)) ///
					asyvars ///
					legend(cols(1)) ///
					title("Probabilities for Non-Science Grades Latent Class") ///
					ytitle("Probability") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_comp1_non_sci_20170411_cp_v1.wmf", replace as(wmf)
					
* Good Grades

graph bar class4, 	over(sample, label(alternate labsize(vsmall)) ) ///
					over(var, label(alternate)) ///
					asyvars ///
					legend(cols(1)) ///
					title("Probabilities for Good Grades Latent Class") ///
					ytitle("Probability") ///
					yscale(range(0 1)) ///
					ymtick(0(0.1)1) ///
					ylabel(0(0.1)1) ///
					note(" " "All pupils gaining a GCSE pass at grades A-G, YCS Cohorts 5-11") ///
					graphregion(color(white))					

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_comp1_good_grades_20170411_cp_v1.wmf", replace as(wmf)


***

* Measurement Invariance Charts

* From "ycs5_11_lca_cohort_comparison_20170210_cp_v1.do"

* This do file uses the latter part of '5_ycs5_11_file5_exploratory_lca.do'
* This contains the cohort by LCA analysis

* I must have run the LCA on each cohort separately as I don think the combined model fitted
* As previously deduced, this is functionally equivalent to fitting a combined model

clear
input year	n	var	class1	class2	class3	class4
1990	7736	1	0.25632662	0.04106897	0.4324014	0.27020301
1990	7736	2	0.16491004	0.31687332	0.98183589	0.79080967
1990	7736	3	0.06114766	0.77483183	0.9235334	0.30871505
1990	7736	4	0.08804429	0.99972586	0.94409642	0.27208382
1990	7736	5	0.10162847	0.43665192	0.9441248	0.58010913
1990	7736	6	0.28057634	0.50969165	0.92197184	0.69638681
1992	14720	1	0.22796964	0.09794158	0.45868852	0.21540026
1992	14720	2	0.16311127	0.48338649	0.98277317	0.81375482
1992	14720	3	0.0495222	0.5572001	0.94171682	0.30691381
1992	14720	4	0.04820065	0.76226183	0.90871389	0.1405872
1992	14720	5	0.08246449	0.46995932	0.95139559	0.57811021
1992	14720	6	0.25832723	0.61537264	0.92957921	0.70190483
1993	10712	1	0.19463517	0.11436188	0.4832911	0.20771184
1993	10712	2	0.14848067	0.60980572	0.98887324	0.81751474
1993	10712	3	0.04937653	0.59554638	0.93820246	0.2536596
1993	10712	4	0.06024215	0.81478469	0.9181082	0.11334446
1993	10712	5	0.06766897	0.48502076	0.96687926	0.53896182
1993	10712	6	0.27615891	0.69098259	0.95102016	0.71024339
1995	9280	1	0.20058709	0.09861868	0.53076687	0.17002736
1995	9280	2	0.17361066	0.55030714	0.98986047	0.90986106
1995	9280	3	0.03127714	0.57368663	0.92166771	0.21235321
1995	9280	4	0.02380624	0.81055452	0.97094312	0.2138887
1995	9280	5	0.05198029	0.38848466	0.94574567	0.51615776
1995	9280	6	0.3213805	0.68230455	0.97342503	0.8566784
1997	8666	1	0.18161818	0.13557561	0.55357222	0.129234
1997	8666	2	0.23211562	0.63817186	0.97816336	0.88342505
1997	8666	3	0.03864749	0.50187365	0.91877744	0.15975009
1997	8666	4	0.04315503	0.73815813	0.95889499	0.14442891
1997	8666	5	0.05008069	0.39658126	0.94825096	0.5234485
1997	8666	6	0.31202085	0.68499598	0.97678996	0.89397195
1999	7103	1	0.16292031	0.1113258	0.56368994	0.16206395
1999	7103	2	0.21656245	0.58982601	0.99729208	0.97376344
1999	7103	3	0.04612148	0.61153498	0.93560442	0.27016756
1999	7103	4	0.05812393	0.80150896	0.97283189	0.28392296
1999	7103	5	0.07098594	0.49386134	0.95979772	0.54242723
1999	7103	6	0.39114034	0.75057073	0.98583645	0.89795437
2001	9720	1	0.12833242	0.08579625	0.61405879	0.17181253
2001	9720	2	0.23585189	0.59618977	0.98694941	0.83822888
2001	9720	3	0.03990202	0.53892298	0.92869553	0.25612748
2001	9720	4	0.04852892	0.87151168	0.96728913	0.1797979
2001	9720	5	0.03869924	0.41939296	0.94717605	0.49018326
2001	9720	6	0.32650393	0.67571967	0.98553465	0.86220617
end

/*
input 	year	n	var	class1		class2		class3		class4
		all	67937	1	0.19404149	0.0828906	0.51781766	0.20525025
		all	67937	2	0.17843518	0.49101741	0.9855928	0.85186851
		all	67937	3	0.04374781	0.59744169	0.93190052	0.264742
		all	67937	4	0.05088038	0.78606879	0.94709773	0.22674231
		all	67937	5	0.07273939	0.42568608	0.94889892	0.54070442
		all	67937	6	0.29666264	0.63956627	0.96017723	0.77606721
*/

label define varlab ///
1 "Prior Prob" ///
2 "English A*-C" ///
3 "Maths A*-C" ///
4 "Science A*-C" ///
5 "Humanity A*-C" ///
6 "Other Sub A*-C" ///

label values var varlab

rename class1 poor
rename class2 sci
rename class3 good
rename class4 nonsci

order good, after(nonsci)

set more off
list

/*
graph bar poor if var!=1, 	over(year, label(alternate)) ///
							over(var)
*/
							
***

* Reshape the dataset long - create one outcome variable "Probability"

rename poor class1
rename sci class2
rename nonsci class3
rename good class4

* gen obs = _n
* order obs, first

set more off
list

reshape long class, i(year n var) j(lat_class)
rename class prob

set more off
list

***

* Chart

label define latclass ///
1 "Poor Grades" ///
2 "Science" ///
3 "Non-Science" ///
4 "Good Grades"

label values lat_class latclass

* Variation in Latent Class membership (latent class / prior probabilities)

set scheme s2color

graph bar prob if var==1, 	over(year, label(alternate labsize(vsmall) ) ) ///
							over(lat_class) ///
							title("Latent Class Probabilities by Year") ///
							subtitle("Differential-item functioning model" " ") ///
							ytitle("Probability") ///
							note(" " "All pupils gaining a GCSE pass at grades A-G, n=67,937, YCS Cohorts 5-11") ///
							graphregion(color(white))
							
graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_cohort_measurement_var_20170407_cp_v1.wmf", replace as(wmf)
							
* Science: variation in conditional probabilities over time

graph bar prob if lat_class==2 & var!=1, 	over(year, label(alternate labsize(vsmall) ) ) ///
											over(var, label(alternate)) ///
							title("Conditional Probabilities for Science Latent Class") ///
							subtitle("Differential-item functioning model" " ") ///
							ytitle("Probability") ///
							note(" " "All pupils gaining a GCSE pass at grades A-G, n=67,937, YCS Cohorts 5-11") ///
							graphregion(color(white)) ///
							bar(1, color(dkgreen))

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_cohort_measurement_var2_20170407_cp_v1.wmf", replace as(wmf)

* Non-Science: variation in conditional probabilities over time

graph bar prob if lat_class==3 & var!=1, 	over(year, label(alternate labsize(vsmall) ) ) ///
											over(var, label(alternate) ) ///
											title("Conditional Probabilities for Non-Science Latent Class") ///
											subtitle("Differential-item functioning model" " ") ///
											ytitle("Probability") ///
											note(" " "All pupils gaining a GCSE pass at grades A-G, n=67,937, YCS Cohorts 5-11") ///
											graphregion(color(white)) ///
											bar(1, color(sienna))

graph export "A:\Conferences\2017 04 Q-Step Edinburgh\lca_model_cohort_measurement_var3_20170407_cp_v1.wmf", replace as(wmf)

clear

***

* Find out proportion of young people gaining Science A*-C pass by Latent Class

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

use $path3\ycs5_to_11_set5.dta, clear
numlabel _all, add

svy: proportion english if sample3==1, over(sample3_modal_class)
svy: proportion english if sample3==1

svy: proportion maths if sample3==1, over(sample3_modal_class)
svy: proportion maths if sample3==1

svy: proportion science if sample3==1, over(sample3_modal_class)
svy: proportion science if sample3==1

* Inserted into slide - "Benchmark School GCSE Attainment by Latent Group (Column Percentages)"

clear

* END *


* http://www.statalist.org/forums/forum/general-stata-discussion/general/1335274-tabplot-updated-on-ssc

/*
graph bar (count) [fw=freq], over(health, descending) over(agegroup) 
percent subtitle(% of age group) stack asyvars 
bar(5, bfcolor(red*0.8)) bar(4, bfcolor(red*0.3) blcolor(red*0.8)) 
bar(3, bfcolor(blue*0.2) blcolor(blue*1.2)) bar(2, bfcolor(blue*0.7) blcolor(blue*1.2)) 
bar(1, bcolor(blue*1.2)) legend(pos(3) col(1)) ysc(r(-5 100)) yla(, ang(h))
*/
