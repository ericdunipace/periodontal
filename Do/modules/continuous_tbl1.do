***** continuous.do *****
putexcel A`3' = "`2'"
svy, over(periodont_stage): mean `1'
mat meanvar = r(table)[1,1...]

estat sd
mat sdvar = r(sd)[1,1...]

local ncol = colsof(r(sd))
foreach a of numlist 1/`ncol' {
	local meanstring = string(meanvar[1,`a'],"%9.1f")
	local sdstring = string(sdvar[1,`a'],"%9.1f")
	local meansd = "`meanstring' ± `sdstring'"
	local colnum = `a' + 1
	local col: word `colnum' of `c(ALPHA)'
	putexcel `col'`3' = "`meansd'"
}

svy: reg `1' i.periodont_stage
local pval_temp = `e(p)'
if `pval_temp' < 0.0001 {
	local pval_temp = "<0.0001"
} 
else {
	local pval_temp = string(`pval_temp', "%9.4f")
}

putexcel E`3' = "`pval_temp'"
// putexcel E`3' = `e(p)'

global index = `3' + 1
***** end of continuous.do *****
