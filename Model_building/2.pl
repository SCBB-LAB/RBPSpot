$file=$ARGV[0];
$file=~s/_motif_position//g;
open(fm,">$file\_positive_data.bed");
open(fh,"$ARGV[0]");
while(<fh>)
{
chomp $_;
@arr=split(/\t/,$_);
@nit1=split(/\:/,$arr[0]);
$nit1[0]=~s/\>//g;
@nit2=split(/\(/,$nit1[1]);
$nit2[1]=~s/\)//g;
@nit3=split(/\-/,$nit2[0]);
$chr=$nit1[0];
$chr=~s/C/c/g;
$start=$nit3[0];
$end=$nit3[1];
$strand=$nit2[1];
$arr[1]=~s/\[//g;
$arr[1]=~s/\]//g;
@arr3=split(/\,/,$arr[1]);

foreach $var(@arr3)
{

print fm $chr,"\t",($start+$var)-75,"\t",$start+$var+$ARGV[1]+75,"\tdummy\t255\t",$strand,"\n";
}
}
close(fm);

`bedtools getfasta -fi hg19.fa -s -tab -bed $file\_positive_data.bed -fo $file\_positive_data.fa`;
`cat $file\_positive_data.fa | awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/a/, \"A\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/t/, \"T\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/c/, \"C\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/g/, \"G\", \$2)} 1' >temp`;
`mv temp $file\_positive_data.fa`;
