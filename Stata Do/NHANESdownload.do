**********************************************************************
*********************download the demographics!!**********************
**********************************************************************
clear all // clear all memory

//change to download directory
cd "~/GoogleDrive/Research/Kyari Research/Stata Data/Raw"

// URL for the demographics
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DEMO_H.XPT", clear
sort seqn

// Save as a Stata dataset
save "DEMO_H.dta", replace
//
**********************************************************************
*********************download other files*****************************
**********************************************************************
// Oral health data
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OHXPER_H.XPT", clear
sort seqn 
save "OHXPER_H.dta", replace

import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OHQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "OHQ_H.dta", replace


// BP & cholesterol:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "BPQ_H.dta", replace

// BP (sytolic, disastolic):
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPX_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "BPX_H.dta", replace

// medical conditions:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/MCQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "MDC_H.dta", replace

// diabetes:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DIQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "MDM_H.dta", replace

// CKD:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/KIQ_U_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "CKD_H.dta", replace

// Smoking:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SMQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "Smoking_H.dta", replace

// income:
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/INQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "Income_H.dta", replace

// // HCRP :
// import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HSCRP_H.XPT", clear
// // Sort and save as an Stata dataset
// sort seqn 
// save "HSCRP_H.dta", replace
// no C-reactive protein in 2013-2014 data

// BMI :
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BMX_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "BMX_H.dta", replace

//TRIGLYCERIDES
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/TRIGLY_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "TRIGLY_H.dta", replace

//HDL
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HDL_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "HDL_H.dta", replace

//Total cholesterol
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/TCHOL_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "TCHOL_H.dta", replace


//alcohol use
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "ALQ_H.dta", replace

//physical activity
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/PAQ_H.XPT", clear
// Sort and save as an Stata dataset
sort seqn 
save "PAQ_H.dta", replace

