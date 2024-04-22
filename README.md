# SHM_SNP_Analysis
This repository contains a workflow to analyze NGS data to look for the occurrence of somatic hypermutation (SHM) through point mutations.

### SNP_Analysis_1.txt
- You will need to create an HPCC account through the lab. Then, you will need to upload your datafiles to this account and run the lines of code in this file 1-by-1.
- Modified from original file by Dr. Wen Huang

### figureTotalMutRate.R
- This creates a visualization of the point mutations that occurred. You will need to edit the size of the plot based on how many samples you have (first section) - the example is based on three samples stacked vertically. 
- You then can run the final line in the SNP_Analysis_1.txt file on your terminal to create the plot
- Modified from original file by Dr. Wen Huang

### txttocsv.R
- This file converts the output of SNP_Analysis_1.txt into a .csv file to do mutation rate analysis in python. You have to open the output in a text editor and save as a txt first. You also have to add a \ before the first value and at the end of the line in the data.
- Modified from original file by Mackenzie Kapanka

### Save separate .csv files
- I chose to save each sample into a separate .csv file for easier data analysis, examples of which are included 

### 4_5_24_nb.ipymb
- This jupyter notebook contains the mutation rate data analysis. I recommend downloading Visual Studio Code to work with notebooks
- This contains code for calculating the mutation rate at each position in the sequence for each sample, the overall mutation rate for each sample, and  the Mann-Whitney U test comparing controls vs experimental both overall and mutating to each individual base.
