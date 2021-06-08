
*Requirements*

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
11. Download hg19.fa file from UCSC and put it into "Model_building" directory with "hg19.fa" name.

*Running script[model building]*

This script contain two modules:
1. For model building (This module requires CLIP-Seq peak data in bed file format)

To run the script:

./RBPSpot_model <bed_file> <window_size>
  
  E.g.
  ./RBPSpot_model Example.bed 17

bedfile contains peak data for CLIP-seq data, bedfile can be given with any name, but it's name will be used as prefix for all the files generated in this step. And also some of the file will be used in next step.

window size can vary between 17-131. For optimum result try with variable window size.


*Output description [model building]*

bedfile_model
  
  E.g.
  Example.bed_model

Folder contaiining the model file in .pb format and it's assets and variable.



*Running script [Scanning module]*


2. For scanning sequences with built model we requires five files in Model_Scan folder:
(i). Input sequences
(ii). bedfile_model folder [Generated after model building process]
(iii). bedfile_penta_Prob_value [Generated after model building process]
(iv). bedfile_penta_Prob_value [Generated after model building process]
(v). bedfile_primary_motif [Generated after model building process]

To run the script:

./scan <bed_file> <Input_sequence>  <window_size>
  
  E.g.
  Shift "Example.bed_model" directory into Model_Scan directory along with Example.bed_penta_Prob_value, Example.bed_penta_Prob_value and Example.bed_primary_motif files.
  Then run:
  ./scan Example.bed Example_sequence.fa 17

bedfile name must be the same name used in last step at the time of Model_building step.
Input_sequence file must be in single line fasta and sequence length must be >=160 bases.
window_size must be the same number used in Model_building step. As different window size will generate different number of feature vector, hence model will not be able to test any feature vector.



*Output description [Scanning module]*


Input_sequence_output.tsv File contain 3 columns:
Seuqence_name	Start_coordinate	End_coordinate
  
  E.g.
  Example_sequence.fa_output.tsv
  
  Web-server version for 131 RBPs available at:
  
  https://scbb.ihbt.res.in/RBPSpot/
  
  Citation:
  https://www.biorxiv.org/content/10.1101/2021.06.07.447370v1
  
  RBPSpot: Learning on Appropriate Contextual Information for RBP Binding Sites Discovery
  
  DOI: https://doi.org/10.1101/2021.06.07.447370 

