***** categorical table 1 do *****
local idx = `3'
putexcel A`idx' = "`2'"


estpost svy: tab `1' periodont_stage, col percent
local pval_temp = `e(p_Pear)'
if `pval_temp' < 0.0001 {
	local pval_temp = "<0.0001"
} 
else {
	local pval_temp = string(`pval_temp', "%9.4f")
}
putexcel E`idx' = "`pval_temp'"

// putexcel E`idx' = `e(p_Pear)'
mat temp_tab = e(b)

local ncol = colsof(temp_tab)/(3 + 1)
if `ncol' == 3 {
	foreach a of numlist 1/`ncol' {
		local colnum = `a' + 1
		local col: word `colnum' of `c(ALPHA)'
		local sel = (`a' - 1) * 3 + 2
		local cellpercent = string(temp_tab[1,`sel'],"%9.1f")
		putexcel `col'`idx' = "`cellpercent'%"
		//putexcel `col'`idx' = temp_tab[1,`sel'], nformat("#.#")
	}
	local idx = `idx' + 1
}
else if `ncol' > 3 {

	local idx = `idx' + 1

	local nrow = colsof(temp_tab)/4 - 1
	foreach b of numlist 1/`nrow' {
		local label_idx = `b'-1
		putexcel A`idx' = `"`:label(`1') `label_idx''"'
		foreach a of numlist 1/3 {
			local colnum = `a' + 1
			local col: word `colnum' of `c(ALPHA)'
			local sel = `b' + (`nrow' + 1) * (`a' - 1)
			local cellpercent = string(temp_tab[1,`sel'],"%9.1f")
			putexcel `col'`idx' = "`cellpercent'%"
			//putexcel `col'`idx' = temp_tab[1,`sel'], nformat("#.#")
		}
		local idx = `idx' + 1
	}
}
else {
	di "ERROR"
	break
}
global index = `idx'
***** end categorical table 1 do
