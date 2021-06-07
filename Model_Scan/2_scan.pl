$file=$ARGV[0];
$file=~s/_motif_position//g;
open(fm,">$file\_positive_data.bed");
open(fh,"$ARGV[0]");
while(<fh>)
{
chomp $_;
@arr=split(/\t/,$_);
$arr[0]=~s/>//g;
$arr[1]=~s/\[//g;
$arr[1]=~s/\]//g;
@arr3=split(/\,/,$arr[1]);

foreach $var(@arr3)
{
if($var>75){

print fm $arr[0],"\t",$var-75,"\t",$var+$ARGV[1]+75,"\n";
}
}
}
close(fm);

`bedtools getfasta -fi $ARGV[2] -s -tab -bed $file\_positive_data.bed -fo $file\_positive_data.fa`;
`cat $file\_positive_data.fa | awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/a/, \"A\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/t/, \"T\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/c/, \"C\", \$2)} 1'| awk 'BEGIN{FS=OFS=\"\t\"} {gsub(/g/, \"G\", \$2)} 1' >temp`;
`mv temp $file\_positive_data.fa`;
