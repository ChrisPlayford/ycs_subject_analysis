# Analysis of Youth Cohort Study (YCS) data - subject specific outcomes in England and Wales.

Collaborators:

Christopher Playford, University of Exeter  
Vernon Gayle, University of Edinburgh  
Roxanne Connelly, University of Edinburgh  

Funder: This work was supported by the ESRC under Grant ES/R004978/1.

© Christopher Playford, University of Exeter.

Dr Chris Playford (c.j.playford@exeter.ac.uk)  
http://socialsciences.exeter.ac.uk/sociology/staff/playford/  
https://orcid.org/0000-0002-6069-4898  
Twitter: @playford_chris

## Instructions

The files have been written in order and are intended to be run sequentially  

## Inventory of files

| File | Task |
| --- | --- |
| `1_ycs_datasets_file_paths.do` | Sets file paths |
|  |  |
| `2_ycs5_gsce_subjects.do` | YCS5: Recodes raw GCSE subject information into standard GCSE subjects |
| `2_ycs6_gsce_subjects.do` | YCS6: Recodes raw GCSE subject information into standard GCSE subjects  |
| `2_ycs7_gsce_subjects.do` | YCS7: Recodes raw GCSE subject information into standard GCSE subjects  |
| `2_ycs8_gsce_subjects.do` | YCS8: Recodes raw GCSE subject information into standard GCSE subjects  |
| `2_ycs9_gsce_subjects.do` | YCS9: Recodes raw GCSE subject information into standard GCSE subjects  |
| `2_ycs10_gsce_subjects.do` | YCS10: Recodes raw GCSE subject information into standard GCSE subjects  |
| `2_ycs11_gsce_subjects.do` | YCS11: Recodes raw GCSE subject information into standard GCSE subjects  |
|  |  |
| `3_soc2000_labels.do` | Defines the labels for SOC2000 occupation codes |
| `3_ycs10_background_vars.do` | Harmonises YCS10 variables with standard variable naming convention (as per UKDS SN5765) |
| `3_ycs10_background_vars_check.do` | Validation of harmonised Variables from YCS10 with SN5765 |
| `3_ycs10_soc2000_recode.do` | Converts SOC2000 codes in YCS10 into standard SOC2000 codes |
| `3_ycs11_background_vars.do` | Harmonises YCS11 variables with standard variable naming convention (as per UKDS SN5765) |
| `3_ycs5_789_background_vars.do` | Collates a subset of standardised variables from YCS5, 7, 8, and 9 into a dataset |
| `3_ycs6_background_vars.do` | Harmonises YCS6 variables with standard variable naming convention (as per UKDS SN5765) |
|  |  |
| `4_inspection_background_vars_datasets.do` | Exports a list of background variables from YCS5-11 into spreadsheet `ycs_background_variables.xlsx` |
| `4_inspection_gcse_subjects_datasets.do` | Exports a list of GCSE subject variables from YCS5-11 into spreadsheet `ycs_gcse_subjects_variables.xlsx` |
| `4_ycs5_11_append_merge.do` | Appends and merges all variables from YCS5-11 into a single dataset |
| `4_ycs5_11_link_class_variables.do` | Links social class information from CAMSIS website |
| `4_ycs5_11_recoding_preparation.do` | Constructs further derived variables including GCSE subject groupings, parental social class measures and identifies analytical samples |
|  |  |
| `5_ycs5_11_file1_exploratory_lca.do` | Exploratory latent class models |
| `5_ycs5_11_file2_assignment.do` | Sensitivity analysis using foreign language GCSE grouping |
| `5_ycs5_11_file3_exploratory_mlogit.do` | Exploratory mlogit model predicting latent group membership using modal assignment |
| `5_ycs5_11_file4_replication_youth_studies.do` | Replication of Youth Studies paper (Playford and Gayle 2016) |
| `5_ycs5_11_file5_exploratory_lca.do` | Testing for measurement invariance (LCA on separate cohorts) |
| `5_ycs5_11_file6_qstep_charts.do` | Charts for Q-step presentation Edinburgh 2017 |
| `5_ycs5_11_file7_post_qstep_charts.do` | Additional charts following Q-step presentation Edinburgh 2017 |
| `5_ycs5_11_file8_sensitivity_analysis.do` | Verification using new GSEM package in Stata and reptition of factor analysis |
| `5_ycs5_11_file9_gsem.do` | Sensitivity analysis: LCA using proportional assignment and one-step LCA using GSEM |
| `5_ycs5_11_file10_agglomerate_models_efa.do` | Estimation of agglomerate GCSE attainment models and factor analysis |
|  |  |
| `README.md` | Readme file describing files |
|  |  |
| `ycs10_SOC2000.xlsx` | SOC2000 codes for YCS10 - see `3_ycs10_soc2000_recode.do` |
| `ycs12_ycs13_no_subject_info_20161220_cp_v1.docx` | Explanation of lack of GCSE subject variables in YCS12 and 13 |
| `ycs_background_variables.xlsx` | List of background variables in harmonised YCS5-11 dataset |
| `ycs_gcse_subjects_variables.xlsx` | List of GCSE subject variables in harmonised YCS5-11 dataset |
| `ycs_subject_analysis_plan.txt` | Diary of analytical tasks performed |
| `youth_studies_replication_ycs5_11_20170202_cp_v1.docx` | Output replicating Youth Studies paper (Playford and Gayle 2016) |
