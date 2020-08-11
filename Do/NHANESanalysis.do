**********************************************************************
********************** NHANES ANALYSIS *******************************
**********************************************************************

clear all // clear all memory

**** load data ****
* set working directory
cd "~/GoogleDrive/Research/Kyari Research/" //make sure makes sense for your machine

* read-in data
use "Data/nhanes_cleaned.dta", clear

 
* set survey parameters
svyset [pweight=sample_weight_med_exam], strata (var_stratum) psu(var_psu) singleunit(centered) //periodontal exam seems to be part of med exam


* set confounder variables
local confounders age_gt65 male white married edu_lte_hs ib4.inc_cat bmi current_smoker diabetes htn hchol ckd alcohol phys

local confounder_names `" "Age ≥ 65" "Male" "Non-hispanic white" "Ever married" "High school graduate or less" "Annual household income" "Body Mass Index" "Current smoker" "Diabetes" "Hypertension" "High cholesterol" "Chronic kidney disease" "Alcohol" "Physical activity" "'

* set regression variables of interest
local  ps_vars i.periodont_stage `confounders'

local ps_varnames `" "Periodontal disease" `confounder_names' "'

drop if periodont_stage == .

**** Final regression sample ****
quietly svy: logistic cad_stroke i.oral_health `ps_vars'

gen byte used=e(sample)

drop if used == 0

//drop unused levels
la def mylabel 1 "unused"
la def mylabel2 3 "unused"
labelbook, problems
la drop `r(notused)'

******** Do files to generate tables ******
global cont = "Do/modules/continuous_tbl1.do"
global cat = "Do/modules/categorical_tbl1.do"
global uni = "Do/modules/univariable_regression.do"
global multi = "Do/modules/multivariable_regression.do"

 
********************** TABLE 1 *******************************
* setup excel file
putexcel set Tables/tables.xlsx, sheet("Table 1") replace

putexcel B1 = "Periodontal Disease"
putexcel A1 = "Variables"
putexcel B2 = "Stage 1"
putexcel C2 = "Stage 2"
putexcel D2 = "Stage 3 - Stage 4"
putexcel E1 = "p-value"

* Numbers of patients
global index = 3
di $index
tab periodont_stage, matcell(cnt1)
putexcel A$index = "Number of observations"
putexcel B$index = cnt1[1,1]
putexcel C$index = cnt1[2,1]
putexcel D$index = cnt1[3,1]
global index = $index + 1
svy: tab periodont_stage, count format(%13.2fc)
mat cnt = e(b) * e(N_pop)
putexcel A$index = "Equivalent population number"
putexcel B$index = cnt[1,1]
putexcel C$index = cnt[1,2]
putexcel D$index = cnt[1,3]
global index = $index + 1

quietly{
* age 
do "$cont" age "Age in years (S.D.)" $index

* male :
do "$cat" male "Male" $index

* white :
do "$cat" white "Non-hispanic white" $index

* marriage :
do "$cat" married "Ever married" $index

* education :
do "$cat" edu_lte_hs "High School or less" $index

* income :
do "$cat" inc_cat "Annual household income" $index

* bmi 
do "$cont" bmi "Body Mass Index (kg/m2)" $index

* SBP
do "$cont" systolic "Systolic blood pressure (mmHg)" $index

* DBP
do "$cont" diastolic "Diastolic blood pressure (mmHg)" $index


* CAD/stroke
do "$cat" cad_stroke "Coronary artery disease and stroke" $index

* Current cigarette smoker
do "$cat" current_smoker "Current cigarette smoker" $index

* DM
do "$cat" diabetes "Diabetes" $index

* HTN
do "$cat" htn "Hypertension" $index


*variables that need special sample weights
*triglyceride
svyset [pweight=sample_weight_triglycerides], strata (var_stratum) psu(var_psu) singleunit(centered)

* high cholesterol
do "$cat" hchol "High Cholesterol Diagnosis" $index


* total cholesterol
do "$cont" total_cholesterol "Total cholesterol (mg/dL)" $index

* LDL
do "$cont" ldl "LDL-cholesterol (mg/dL)" $index

* HDL
do "$cont" hdl "HDL-cholesterol (mg/dL)" $index

* Triglycerides
do "$cont" triglyceride "Triglycerides (mg/dL)" $index
 
 
 
*reset survey parameters
svyset [pweight=sample_weight_med_exam], strata (var_stratum) psu(var_psu) singleunit(centered)

* Chronic kidney disease
do "$cat" ckd "Chronic kidney disease" $index

* Alcohol
do "$cat" alcohol "Any alcohol consumption" $index

* Physical activity
do "$cont" phys "Physical activity (min/day)" $index
}

********************** Prevalence Data *******************************
putexcel set "Tables/tables.xlsx", sheet("Prevalence") modify
putexcel A1 = "Variable"
putexcel A2 = "CAD and/or Stroke"
quietly estpost svy: tab cad_stroke, col percent
mat cad_mat = e(b)
putexcel B2 = cad_mat[1,2], nformat("#.#")
putexcel A4 = "Periodontal disease stage"
putexcel B4 = "Stage 1"
putexcel C4 = "Stage 2"
putexcel D4 = "Stage 3 – Stage 4"
quietly estpost svy: tab periodont_stage, col percent
mat ps_mat = e(b)
putexcel B5 = ps_mat[1,1], nformat("#.#")
putexcel C5 = ps_mat[1,2], nformat("#.#")
putexcel D5 = ps_mat[1,3], nformat("#.#")

********************** Univariable analysis *******************************
putexcel set "Tables/tables.xlsx", sheet("Univariate Regression") modify

putexcel A1 = "Variable"
putexcel B1 = "Odds Ratio"
putexcel C1 = "p-value"

global index = 2

local univars i.oral_health i.periodont_stage `confounders'

local uni_varnames `" "Oral health" "Periodontal disease" `confounder_names' "'
	
local n : word count `uni_varnames'

forvalues i = 1/`n' {
	local a : word `i' of `uni_varnames'
	local b : word `i' of `univars'
	di "`b'"
	quietly do "$uni" `b' "`a'" $index
}


********************** Multivariable analysis: periodontal exam *******************************
putexcel set "Tables/tables.xlsx", sheet("Periodontal Stage Regression") modify

putexcel A1 = "Variable"
putexcel B1 = "Odds Ratio"
putexcel C1 = "p-value"

global index = 2


quietly do "$multi" "`ps_vars'" "$index" `ps_varnames' 




********************** Multivariable analysis: oral health rating *******************************

putexcel set "Tables/tables.xlsx", sheet("Oral Health Regression") modify

putexcel A1 = "Variable"
putexcel B1 = "Odds Ratio"
putexcel C1 = "p-value"

global index = 2


local os_varnames `" "Oral health" `confounder_names' "'
local os_vars i.oral_health `confounders'

quietly do "$multi" "`os_vars'" "$index" `os_varnames' 
putexcel close


**** end analysis do file ****
