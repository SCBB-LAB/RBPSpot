use List::Util qw/shuffle/;
$file=$ARGV[0];
$file=~s/_motif_position//g;
open(fm,">$file\_negative_data.bed");
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
$counter=0;
@new_arr=shuffle @arr3;
@arr3="";
@arr3 = @new_arr;
foreach $var(@arr3)
{
if($counter<=5)
{
print fm $chr,"\t",($start+$var)-75,"\t",$start+$var+$ARGV[1]+75,"\tdummy\t255\t",$strand,"\n";
}
$counter++;
}
}
close(fm);

`bedtools getfasta -fi hg19.fa -s -tab -bed $file\_negative_data.bed -fo $file\_negative_data.fa`;
`cat $file\_negative_data.fa | awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/a/, \"A\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/t/, \"T\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/c/, \"C\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/g/, \"G\", \$2)} 1' |shuf |head -$ARGV[2] >temp`;
`mv temp $file\_negative_data.fa`;
