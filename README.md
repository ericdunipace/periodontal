# Association between periodontal disease and CAD + Stroke

This repository replicates the code in a [paper](https://pubmed.ncbi.nlm.nih.gov/35773046/) examining the association between periodontal disease stage and the occurence of coronary artery disease + stroke. *NB*: this code was modified after by the first two authors who have not made their results reproducible. The results should be roughly the same but this is why there would be any differences.

To download the code,

1. Click on "Code"
2. Either download a zip file or clone the repository

All code files are in Stata ".do" format. To run requires the Stata (commercial) software. Stata MP 16.1 was used in the original analysis.

The git folder will be the home directory for analyses. 
If you need to 
1. Re-download the data, use the "Do/NHANESdownload.do" file
2. Re-merge the data, use the "Do/NHANESdownload.do" file
3. Re-analyze the data, use the "Do/NHANESanalysis.do" file

You will have to edit the folder references in the above files for everything to work properly. Make sure they make sense for your machine.

The folder "Data" contains the already downloaded data files and the folder "Tables" contains the generated tables in Microsoft ".xlsx" format.
