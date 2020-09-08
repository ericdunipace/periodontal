***** univariate.do *****
local idx = `3'
// di `idx'

svy: logistic cad_stroke `1'
mat reg_tab = r(table)
mat coef = reg_tab[1,1...]
mat lw = reg_tab[5,1...]
mat up = reg_tab[6,1...]
local pval = `e(p)'
if `pval' < 0.0001 {
	local pval = "<0.0001"
} 
else {
	local pval = string(`pval', "%9.4f")
}

putexcel C`idx' = "`pval'"

local names : colfullnames e(b)

local pos = strpos("`names'", ".") + 1
local names = substr("`names'", `pos', .)
local newlist `newlist' `names'
// di "`newlist'"

local curvar : word 1 of `newlist'
// di "`curvar'"

putexcel A`idx' = "`2'"

local ncol = colsof(reg_tab)
// di `ncol'
if `ncol' > 2 {
	local idx = `idx' + 1
	local nrow = `ncol' - 1
	foreach b of numlist 1/`nrow' {
// 		di `b'
		local label_idx = `b'-1
		putexcel A`idx' = `"`:label(`curvar') `label_idx''"'
		if lw[1,`b'] == . {
			local output = "(Reference)"
		}
		else {
// 			di "coef"
			local val = string(reg_tab[1,`b'] ,"%9.2f")
// 			di "lower"
			local lstring = string(lw[1,`b'] ,"%9.2f")
// 			di "upper"
			local ustring = string(up[1,`b'] ,"%9.2f")
// 			di "output"
			local output = "`val' (`lstring' – `ustring')"
		}
		
		
		putexcel B`idx' = "`output'"
		
		local idx = `idx' + 1
// 		di "index"
// 		di `idx'
	}
} 
else {
	local val = string(reg_tab[1,1] ,"%9.2f")
	local lstring = string(lw[1,1] ,"%9.2f")
	local ustring = string(up[1,1] ,"%9.2f")
	local output = "`val' (`lstring' – `ustring')"
	putexcel B`idx' = "`output'"
	local idx = `idx' + 1
}
global index = `idx'
***** end of univariate.do *****
