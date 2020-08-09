****** multivariable_regression.do ********
local idx = `2'

svy: logistic cad_stroke `1'
mat reg_tab = r(table)
mat coef = reg_tab[1,1...]
mat lw = reg_tab[5,1...]
mat up = reg_tab[6,1...]
mat pval = reg_tab[4,1...]

local names : colnames e(b)
local n : word count `names'
local n = `n' - 1
// di `n'
// di "`names'"
local oldvar = ""
local name_idx = 3
forvalues i = 1/`n' {
	local curvar : word `i' of `names'
// 	di "`curvar'"
	local pos = strpos("`curvar'", ".") + 1
// 	di `pos'
	if `pos' > 1 {
		local label_idx = substr("`curvar'", 1, 1)
		local curvar = substr("`curvar'", `pos', .)
	}
// 	di "`curvar'"
// 	di "`label_idx'"
// 	local test1 : list "`curvar'" != "`oldvar'"
	if "`curvar'" != "`oldvar'" {
		putexcel A`idx' = "``name_idx''"
		local name_idx = `name_idx' + 1
		if `pos' > 1 {
			local testvar = "i.`curvar'"
			testparm `testvar'
			putexcel C`idx' = `r(p)'
			local idx = `idx' + 1
			putexcel A`idx' = `"`:label(`curvar') `label_idx''"'
		}
	} 
	else {
// 		di "oldvar == curvar"
		putexcel A`idx' = `"`:label(`curvar') `label_idx''"'
	}
	if lw[1,`i'] == . {
		local output = "(Reference)"
	}
	else {
		local val = string(reg_tab[1,`i'] ,"%9.2f")
		local lstring = string(lw[1,`i'] ,"%9.2f")
		local ustring = string(up[1,`i'] ,"%9.2f")
		local output = "`val' (`lstring', `ustring')"
	}
		
		
	putexcel B`idx' = "`output'"
	putexcel C`idx' = pval[1,`i']
	
	local idx = `idx' + 1 
	local oldvar = "`curvar'"
// 	di "Oldvar: `oldvar'"
// 	di "new loop\n"
}

estat gof, group(10) // rejecting means model not fit

local idx = `idx' + 1
local df1 = string(`r(df1)',"%9.0f")
local df2 = string(`r(df2)',"%9.0f")
local F = string(`r(F)',"%9.2f")

putexcel A`idx' = "Goodness of fit"
putexcel B`idx' = "F(`df1', `df2') = `F' "
putexcel C`idx' = `r(p)'


global index = `idx'
***** end of  multivariable_regression.do *****


