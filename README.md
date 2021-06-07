===============
*Requirements*
===============
1. Python3
2. Numpy
3. Pandas
4. perl
5. sklearn
6. xgboost
7. bedtools
8. keras
9. tensorflow
10. gcc
==================
*Running script[model building]*
==================
This script contain two modules:
1. For model building (This module requires CLIP-Seq peak data in bed file format)

To run the script:

./RBPSpot_model bedfile <window size>

bedfile contains peak data for CLIP-seq data, bedfile can be given with any name, but it's name will be used as prefix for all the files generated in this step. And also some of the file will be used in next step.

window size can vary between 17-131. For optimum result try with variable window size.

==================
*Output description [model building]*
==================
bedfile_model

Folder contaiining the model file in .pb format and it's assets and variable.


==================
*Running script [Scanning module]*
==================

2. For scanning sequences with built model we requires five files in Model_Scan folder:
(i). Input sequences
(ii). bedfile_model folder [Generated after model muilding process]
(iii). bedfile_penta_Prob_value [Generated after model muilding process]
(iv). bedfile_penta_Prob_value [Generated after model muilding process]
(v). bedfile_primary_motif [Generated after model muilding process]

To run the script:

./scan bedfile <Input_sequence>  <window_size>

bedfile name must be the same name used in last step at the time of Model_building step.
Input_sequence file must be in single line fasta and sequence length must be >=160 bases.
window_size must be the same number used in Model_building step. As different window size will generate different number of feature vector, hence model will not be able to test any feature vector.


==================
*Output description [Scanning module]*
==================

Input_sequence_output.tsv File contain 3 columns:
Seuqence_name	Start_coordinate	End_coordinate

