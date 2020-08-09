**********************************************************************
*********************merge datsets************************************
**********************************************************************
clear all // clear all memory

*project repository
cd "~/GoogleDrive/Research/Kyari Research/" //make sure makes sense for your machine

*change to folder where raw data will be
cd "Data/Raw"


use "DEMO_H.dta", clear //demographics
merge 1:1 seqn using "BPQ_H.dta" // bloood pressure & cholesterol
drop  _merge

merge 1:1 seqn using "BPX_H.dta" // bloood pressure (sys/dia) * use exam sample weights!!!
drop  _merge

merge 1:1 seqn using "CKD_H.dta" // kidney data
drop  _merge

merge 1:1 seqn using "MDC_H.dta"
drop  _merge

merge 1:1 seqn using "MDM_H.dta"
drop  _merge

merge 1:1 seqn using "OHXPER_H.dta" // peridontal exam, think need exam sample weights
drop  _merge

merge 1:1 seqn using "OHQ_H.dta" // oral health
drop  _merge

merge 1:1 seqn using "Smoking_H.dta" // smoking data
drop  _merge

merge 1:1 seqn using "Income_H.dta" //income data
drop  _merge

// merge 1:1 seqn using "HSCRP_H.dta" // code for C-reactive protein. not present in data
// drop  _merge

merge 1:1 seqn using "BMX_H.dta" //bmi data
drop  _merge

merge 1:1 seqn using "TRIGLY_H.dta" //triglyceride and ldl data *special sample weights!!!!
drop  _merge

merge 1:1 seqn using "HDL_H.dta" //hdl data * use exam sample weights!!!
drop  _merge

merge 1:1 seqn using "TCHOL_H.dta" //total chol data * use exam sample weights!!!
drop  _merge

merge 1:1 seqn using "ALQ_H.dta" //alcohol data
drop  _merge

merge 1:1 seqn using "PAQ_H.dta" //physical activity data, if join with data from mec, use mec weights
drop  _merge

* reduce data set size to make easier to visually examine

keep seqn ohx02lad ohx02las ohx02lap ohx02laa ohx03lad ohx03las ohx03lap ohx03laa ohx04lad ohx04las ohx04lap ohx04laa ohx05lad ohx05las ohx05lap ohx05laa ohx06lad ohx06las ohx06lap ohx06laa ohx07lad ohx07las ohx07lap ohx07laa ohx08lad ohx08las ohx08lap ohx08laa ohx09lad ohx09las ohx09lap ohx09laa ohx10lad ohx10las ohx10lap ohx10laa ohx11lad ohx11las ohx11lap ohx11laa ohx12lad ohx12las ohx12lap ohx12laa ohx13lad ohx13las ohx13lap ohx13laa ohx14lad ohx14las ohx14lap ohx14laa ohx15lad ohx15las ohx15lap ohx15laa ohx18lad ohx18las ohx18lap ohx18laa ohx19lad ohx19las ohx19lap ohx19laa ohx20lad ohx20las ohx20lap ohx20laa ohx21lad ohx21las ohx21lap ohx21laa ohx22lad ohx22las ohx22lap ohx22laa ohx23lad ohx23las ohx23lap ohx23laa ohx24lad ohx24las ohx24lap ohx24laa ohx25lad ohx25las ohx25lap ohx25laa ohx26lad ohx26las ohx26lap ohx26laa ohx27lad ohx27las ohx27lap ohx27laa ohx28lad ohx28las ohx28lap ohx28laa ohx29lad ohx29las ohx29lap ohx29laa ohx30lad ohx30las ohx30lap ohx30laa ohx31lad ohx31las ohx31lap ohx31laa wtint2yr wtmec2yr sdmvpsu sdmvstra seqn ridageyr riagendr indhhin2 bpq080 bpq020 bpq030 bmxbmi mcq160b mcq160c mcq160d mcq160e mcq160f diq010 kiq022 smq040 smq020 ind235 ohq845 ridreth3 dmdmartl dmdeduc2 bpxsy1 bpxdi1 lbxtr lbdldl wtsaf2yr lbdhdd lbxtc alq101 pad615 pad630 pad645 pad660 pad675

recode ohx02lad ohx02las ohx02lap ohx02laa ohx03lad ohx03las ohx03lap ohx03laa ohx04lad ohx04las ohx04lap ohx04laa ohx05lad ohx05las ohx05lap ohx05laa ohx06lad ohx06las ohx06lap ohx06laa ohx07lad ohx07las ohx07lap ohx07laa ohx08lad ohx08las ohx08lap ohx08laa ohx09lad ohx09las ohx09lap ohx09laa ohx10lad ohx10las ohx10lap ohx10laa ohx11lad ohx11las ohx11lap ohx11laa ohx12lad ohx12las ohx12lap ohx12laa ohx13lad ohx13las ohx13lap ohx13laa ohx14lad ohx14las ohx14lap ohx14laa ohx15lad ohx15las ohx15lap ohx15laa ohx18lad ohx18las ohx18lap ohx18laa ohx19lad ohx19las ohx19lap ohx19laa ohx20lad ohx20las ohx20lap ohx20laa ohx21lad ohx21las ohx21lap ohx21laa ohx22lad ohx22las ohx22lap ohx22laa ohx23lad ohx23las ohx23lap ohx23laa ohx24lad ohx24las ohx24lap ohx24laa ohx25lad ohx25las ohx25lap ohx25laa ohx26lad ohx26las ohx26lap ohx26laa ohx27lad ohx27las ohx27lap ohx27laa ohx28lad ohx28las ohx28lap ohx28laa ohx29lad ohx29las ohx29lap ohx29laa ohx30lad ohx30las ohx30lap ohx30laa ohx31lad ohx31las ohx31lap ohx31laa (99=.)


******************** create variables will use ********************
* y/n label
label define yn_l 0 "No" 1 "Yes"

//drop missing or young people
drop if ridageyr <18 // drops those under 18 (our analysis drops those under 30)
drop if indhhin2>15 // drops categories of refused, missing, don't know
// drop if bpq030>2 // drops categories of refused, missing, don't know
drop if bpq080>2 // drops categories of refused, missing, don't know
drop if kiq022>2 // drops categories of refused, missing, don't know
// drop if mcq160c>2 // drops categories of refused, missing, don't know
drop if diq010>2 // drops categories of refused, missing, don't know, borderline (which is 3)
drop if ohq845>5 // drop refused don't know missing

// OUTCOME variable
// MCQ160c - Ever told you had coronary heart disease
// MCQ160d - Ever told you had angina/angina pectoris
// MCQ160e - Ever told you had heart attack
// MCQ160f - Ever told you had a stroke
//cvd
gen cvd = 0
replace cvd = 1 if mcq160c == 1 | mcq160d == 1 | mcq160e == 1 | mcq160f == 1
replace cvd = . if mcq160c > 7  & mcq160d > 7 &  mcq160e > 7 & mcq160f > 7
/*replace cvd = 1 if mcq160c == 1 | mcq160f == 1
replace cvd = . if mcq160c > 7  & mcq160f > 7 */
label values cvd yn_l
label variable cvd "Cardiovascular disease"

//only cad + stroke (PER KYARI'S INSTRUCTIONS--but we are missing some CVD this way)
gen cad_stroke = 0
replace cad_stroke = 1 if mcq160c == 1 | mcq160f == 1
replace cad_stroke = . if mcq160c > 7  & mcq160f > 7


// PREDICTOR variables

* alcohol use *
gen alcohol = .
replace alcohol = 1 if alq101 == 1
replace alcohol = 0 if alq101 == 2
label values alcohol yn_l
label variable alcohol "Had at least 12 alcohol drinks/1 yr?"

* age categories *
gen age_cat = 0 if ridageyr <=39 & ridageyr > 29
replace age_cat = 1 if ridageyr >39 & ridageyr <= 49
replace age_cat = 2 if ridageyr > 49 & ridageyr <= 59
replace age_cat = 3 if ridageyr > 59 & ridageyr <= 69
replace age_cat = 4 if ridageyr > 69 & ridageyr < .
label variable age_cat "Age category"
label define age_label 0 "30-39 years" 1 "40-49 years" 2 "50-59 years" 3 "60-69 years" 4 "≥ 70 years"
label values age_cat age_label

gen age_gt65 = .
replace age_gt65 = 0 if ridageyr > 29
replace age_gt65 = 1 if ridageyr >= 65

* blood pressure *
* systolic:
gen systolic = bpxsy1 

*diastolic
gen diastolic = bpxdi1

* education *
// Variable Name: DMDEDUC2SAS Label: Education level - Adults 20+English Text: What is the highest grade or level of school {you have/SP has} completed or the highest degree {you have/s/he has} received?English Instructions: HAND CARD DMQ1 READ HAND CARD CATEGORIES IF NECESSARY ENTER HIGHEST LEVEL OF SCHOOLTarget: Both males and females 20 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Less than 9th grade	455	455	
// 2	9-11th grade (Includes 12th grade with no diploma)	791	1246	
// 3	High school graduate/GED or equivalent	1303	2549	
// 4	Some college or AA degree	1770	4319	
// 5	College graduate or above	1443	5762	
// 7	Refused	2	5764	
// 9	Don't Know	5	5769	
// .	Missing	4406	10175	

gen edu_cat = .
replace edu_cat = 0 if dmdeduc2 == 1
replace edu_cat = 1 if dmdeduc2 == 2
replace edu_cat = 2 if dmdeduc2 == 3
replace edu_cat = 3 if dmdeduc2 == 4 | dmdeduc2 == 5
label variable edu_cat "Education"
label define edu_cat_l 0 "No High School" 1 "Some High School" 2 "Completed High School" 3 "Some College or More"
label values edu_cat edu_cat_l

gen edu_lte_hs = .
replace edu_lte_hs = 0 if edu_cat == 3
replace edu_lte_hs = 1 if edu_cat == 0 | edu_cat == 1 | edu_cat == 2
label variable edu_lte_hs "Did not attend college (YES/NO)"
label values edu_lte_hs yn_l


// label ethnicity variable and rename
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Mexican American	1355	1355	
// 2	Other Hispanic	1076	2431	
// 3	Non-Hispanic White	2973	5404	
// 4	Non-Hispanic Black	2683	8087	
// 6	Non-Hispanic Asian	1282	9369	
// 7	Other Race - Including Multi-Racial	387	9756	
// .	Missing	0	9756	

gen eth = .
replace eth = 0 if ridreth3 == 1
replace eth = 0 if ridreth3 == 2
replace eth = 1 if ridreth3 == 3
replace eth = 2 if ridreth3 == 4
replace eth = 3 if ridreth3 == 6
replace eth = 4 if ridreth3 == 7
label define eth_l 0 "Hispanic" 1 "White, Non-Hispanic" 2 "Black, Non-Hispanic" 3 "Asian, Non-Hispanic" 4 "Other"
label values eth eth_l
label variable eth "Ethnicity"
//created varible if needed but just focusing on non-hispanic white and non-white for now

gen white = .
replace white = 1 if eth == 1
replace white = 0 if eth == 0 | eth == 2 | eth == 3 | eth == 4
label values white yn_l
label variable white "Non-Hispanic White? (No/Yes)"

* hyperlipidemia * (needs medical exam sample weights)
gen hyperlipidemia = 0
replace hyperlipidemia = 1 if lbxtc > 240 & lbxtc < . //total cholesterol
replace hyperlipidemia = 1 if lbdldl > 160 & lbdldl < . //ldl but has special sample weights
replace hyperlipidemia = 1 if lbxtr > 200 & lbxtr < . //triglycerides but has special sample weights
replace hyperlipidemia = . if lbdldl == . & lbxtc == . // & lbxtr == .
//values from https://www.namcp.org/md_resource_centers/Hyperlipidemia/patients/diagnosis.html

//going with above hyperlipidemia
*special hyperlipidemia (needs hyperlipidemia sample weights)
gen tri_hyperlipidemia = 0 
replace tri_hyperlipidemia = 1 if lbxtr > 200 & lbxtr < . 
replace tri_hyperlipidemia = 1 if lbdldl > 160 & lbdldl < . //ldl
replace tri_hyperlipidemia = . if lbxtr == .


/*
*overlap between two vars
gen overlap_hyperlipidemia = 0 
replace overlap_hyperlipidemia = 1 if tri_hyperlipidemia == hyperlipidemia
tab overlap_hyperlipidemia
*/

* hypertension *
// bpq030
// Told had high blood pressure - 2+ times
// English Text: {Were you/Was SP} told on 2 or more different visits that {you/s/he} had hypertension, also called high blood pressure?Target: Both males and females 16 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Yes	1738	1738	
// 2	No	428	2166	
// 7	Refused	0	2166	
// 9	Don't know	8	2174	
// .	Missing	4290	6464	
gen htn = 1 if bpq030 == 1 | bpq030 == 9
// Variable Name: BPQ020
// Label: Ever told you had high blood pressureEnglish 
// Text: {Have you/Has SP} ever been told by a doctor or other health professional that {you/s/he} had hypertension, also called high blood pressure?Target: Both males and females 16 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Yes	2174	2174	
// 2	No	4285	6459	BPQ056
// 7	Refused	0	6459	BPQ056
// 9	Don't know	5	6464	BPQ056
// .	Missing	0	6464	
replace htn = 0 if bpq020 == 2 | bpq030 == 2
label values htn yn_l
label variable htn "Hypertension? (No/Yes)"

*income*
// Variable Name: INDHHIN2
// SAS Label: Annual household income
// English Text: Total household income (reported as a range value in dollars)
// Target: Both males and females 0 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	$ 0 to $ 4,999	273	273	
// 2	$ 5,000 to $ 9,999	407	680	
// 3	$10,000 to $14,999	639	1319	
// 4	$15,000 to $19,999	658	1977	
// 5	$20,000 to $24,999	880	2857	
// 6	$25,000 to $34,999	1185	4042	
// 7	$35,000 to $44,999	913	4955	
// 8	$45,000 to $54,999	764	5719	
// 9	$55,000 to $64,999	521	6240	
// 10	$65,000 to $74,999	378	6618	
// 12	$20,000 and Over	323	6941	
// 13	Under $20,000	133	7074	
// 14	$75,000 to $99,999	860	7934	
// 15	$100,000 and Over	1781	9715	
// 77	Refused	252	9967	
// 99	Don't know	75	10042	
// .	Missing	133	10175	

drop if indhhin2==12 //remove $20,000 and over variable because not sure how to classify
gen inc_cat=0 if indhhin2<5 | indhhin2==13
replace inc_cat=1 if indhhin2 >=5 & indhhin2<7 
replace inc_cat=2 if indhhin2 >=7 & indhhin2<9 
replace inc_cat=3 if indhhin2 >=9 & indhhin2<10 
replace inc_cat=4 if indhhin2 >=14 
label variable inc_cat "Income category"
label define inc_label 0 "< $20,000" 1 "$20,000-$34,999" 2 "$35,000-$54,999" 3 "$55,000 to $74,999" 4 "≥ $75,000"
label values inc_cat inc_label

* Male yes/no
// Variable Name: RIAGENDR
// SAS Label: Gender
// English Text: Gender of the participant.Target: Both males and females 0 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Male	5003	5003	
// 2	Female	5172	10175	
// .	Missing	0	10175	

gen male= 1 if riagendr==1
replace male=0 if riagendr==2
label variable male "Male"
label values male yn_l

// label marriage variable and rename (currently married yes/no)
// Variable Name: DMDMARTLSAS Label: Marital statusEnglish Text: Marital statusTarget: Both males and females 20 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Married	2965	2965	
// 2	Widowed	436	3401	
// 3	Divorced	659	4060	
// 4	Separated	177	4237	
// 5	Never married	1112	5349	
// 6	Living with partner	417	5766	
// 77	Refused	2	5768	
// 99	Don't Know	1	5769	
// .	Missing	4406	10175	

gen married = .
replace married = 0 if dmdmartl == 5 | dmdmartl == 6
replace married = 1 if dmdmartl == 1 | dmdmartl == 2 | dmdmartl == 3 | dmdmartl == 4
label values married yn_l
label variable eth "Ever married (No/Yes)"

// general marital status
gen marital_status = .
replace marital_status = 0 if dmdmartl == 1 
replace marital_status = 1 if dmdmartl == 2
replace marital_status = 2 if dmdmartl == 3
replace marital_status = 3 if dmdmartl == 4
replace marital_status = 4 if dmdmartl == 5
replace marital_status = 5 if dmdmartl == 6
label define marital_status_l 0 "Married" 1 "Widowed" 2 "Divorced" 3 "Separated" 4 "Never Married" 5 "Living with Partner"
label values marital_status marital_status_l
label variable marital_status "Marital Status"

* oral health
// Variable Name: OHQ845 
// SAS Label: Rate the health of your teeth and gums
// English Text: Overall, how would {you/SP} rate the health of {your/his/her} teeth and gums?
// Target: Both males and females 1 YEARS - 150 YEARS
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Excellent	1755	1755	
// 2	Very good	2342	4097	
// 3	Good	3326	7423	
// 4	Fair	1688	9111	
// 5	Poor	651	9762	
// 7	Refused	1	9763	
// 9	Don't know	5	9768	
// .	Missing	2	9770	
gen oral_health = ohq845-1
// replace oral_health = . if ohq845 >= 7 // don't need because drop earlier
label define oral_health_label 0 "Excellent" 1 "Very Good" 2 "Good" 3 "Fair" 4 "Poor"
label values oral_health oral_health_label


// periodontitis
gen periodont_sum = 0
foreach var of varlist ohx02lad-ohx31laa {
 replace periodont_sum = periodont_sum + ( `var' > 0 & `var' < 99 )
}

egen periodont_max = rowmax(ohx02lad-ohx31laa)
replace periodont_sum = . if periodont_max == .

egen periodont_cat = cut(periodont_sum), group(5) label

// generate periodontitis variable
gen periodont = .
replace periodont = 1 if periodont_sum >= 2 & periodont_sum < .
replace periodont = 0 if periodont_sum < 2
label variable periodont "Does the person have periodontitis?"

// setup periodontal stage
gen periodont_stage = .
replace periodont_stage = 0 if periodont_max == 0
replace periodont_stage = 1 if periodont_max >0 & periodont_max <= 2
replace periodont_stage = 2 if periodont_max >2 & periodont_max <= 4
replace periodont_stage = 3 if periodont_max >= 5 & periodont_max <  .
label define periodont_stage_l 0 "None" 1 "Stage 1" 2 "Stage 2" 3 "Stage 3-4"
label values periodont_stage periodont_stage_l
label variable periodont_stage "Stage of periodontitis"

/* commented out because already ran check
//check the people with periodont_sum == 2
tab periodont_sum
gen match_id = .
gen match_count = 0
gen test_flag = 0
replace test_flag = 1 if periodont_sum == 2
forval i = 1/`=_N' {
       qui if (test_flag[`i']) {
                       replace match_id = `i'
					   replace match_count = match_count + 1
	   }
}
*/
tab periodont_stage
// only one person with none
// remove that person and relabel
replace periodont_stage = .
replace periodont_stage = 0 if periodont_max >0 & periodont_max <= 2
replace periodont_stage = 1 if periodont_max >2 & periodont_max <= 4
replace periodont_stage = 2 if periodont_max >= 5 & periodont_max <  .
label define periodont_stage_l2 0 "Stage 1" 1 "Stage 2" 2 "Stage 3-4"
label values periodont_stage periodont_stage_l2
label variable periodont_stage "Stage of periodontitis"


* physical activity
//using various physical activity variables too many to list
generate phys = 0
replace phys = pad615 if pad615 <7777
replace phys = phys + pad630 if pad630 <7777
replace phys = phys + pad645 if pad645 <7777
replace phys = phys + pad660 if pad660 <7777
replace phys = phys + pad675 if pad675 <7777
//replace phys = . if pad615 >= 7777 &  pad630 >= 7777 & pad645 >= 7777 & pad660 >= 7777 & pad675 >= 7777
//assuming missing is 0
label variable phys "minutes of physical activity on a typical day"

*Ever smoke status*
// SMQ020 - Smoked at least 100 cigarettes in life
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Yes	2579	2579	
// 2	No	3532	6111	SMAQUEX2
// 7	Refused	0	6111	SMAQUEX2
// 9	Don't know	2	6113	SMAQUEX2
// .	Missing	1055	7168	

// SMQ040 - Do you now smoke cigarettes
// 1	Every day	992	992	SMQ078
// 2	Some days	240	1232	SMD641
// 3	Not at all	1347	2579	
// 7	Refused	0	2579	SMAQUEX2
// 9	Don't know	0	2579	SMAQUEX2
// .	Missing	4589	7168	

generate smoke=1 if smq040 <=2 | smq020 == 1 // current smoker and non-smoker + smoke more than 100 cigarettes
replace smoke=0 if smq020==2 //not smoked 100 cig and not current smoker
//replaces smoke if smoke less than 100 cigs
label variable smoke "Ever smoked"
label values smoke yn_l

*Current smoker
// smq040
// Code or Value	Value Description	Count	Cumulative	Skip to Item
// 1	Every day	992	992	SMQ078
// 2	Some days	240	1232	SMD641
// 3	Not at all	1347	2579	
// 7	Refused	0	2579	SMAQUEX2
// 9	Don't know	0	2579	SMAQUEX2
// .	Missing	4589	7168	
generate current_smoker = .
replace current_smoker=1 if smq040 <= 2
replace current_smoker=0 if smq040 == 3 | smq020 == 2
label variable current_smoker "Current smoker"
label values current_smoker yn_l


* Make Yes for variable == 1
gen diabetes = abs(diq010 - 2)
gen ckd = abs(kiq022 - 2)
gen hchol= abs(bpq080-2)


* other y/n labels
label values diabetes yn_l
label values ckd yn_l
label values hchol yn_l
label values periodont yn_l

* Generate descriptive labels for these variables
local lab : variable label diq010
label variable diabetes "`lab'"

local lab : variable label kiq022
label variable ckd "`lab'"

local lab : variable label bpq030
label variable htn "`lab'"

local lab : variable label bpq080
label variable hchol "`lab'"

* re-label with sensical varnames
rename wtint2yr sample_weight
rename wtmec2yr sample_weight_med_exam
rename sdmvpsu var_psu
rename sdmvstra var_stratum
rename ridageyr age
rename bmxbmi bmi
rename wtsaf2yr sample_weight_triglycerides
rename lbdldl ldl
rename lbdhdd hdl
rename lbxtr triglyceride
rename lbxtc total_cholesterol

keep seqn sample_weight sample_weight_med_exam var_psu var_stratum sample_weight_triglycerides ///
age age_cat age_gt65 male eth white married marital_status edu_cat edu_lte_hs inc_cat bmi systolic diastolic ///
cvd cad_stroke current_smoker smoke diabetes htn hchol hyperlipidemia ///
total_cholesterol ldl hdl triglyceride ///
ckd alcohol phys oral_health ///
periodont periodont_stage periodont_sum periodont_cat periodont_max



 
//choose where to save (can be specific to your machine but need to be careful about references in NHANESanalysis.do)
cd ".."

save nhanes_cleaned.dta, replace
// end
