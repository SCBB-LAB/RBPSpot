$percent=$ARGV[2];
chomp($ARGV[1]);
$kmer=$ARGV[1];
$previous_kmer=$kmer;
$previous_percent=$percent;
while($percent>=70)
{#print $percent;
$kmer_arr[0]=$kmer."A";
$kmer_arr[1]=$kmer."T";
$kmer_arr[2]=$kmer."C";
$kmer_arr[3]=$kmer."G";
$kmer_arr[4]="A".$kmer;
$kmer_arr[5]="T".$kmer;
$kmer_arr[6]="C".$kmer;
$kmer_arr[7]="G".$kmer;
$percent=0;
for($i=0;$i<=7;$i++)
{
$hit=`./a.out $ARGV[0] $kmer_arr[$i] |grep -v -P "\\[\\]"| wc -l`;
chomp($hit);
#print $hit,"\t";
$total_seq=$ARGV[3];
#print $total_seq,"\n";
$percent1=($hit*100.0)/$total_seq;
if($percent<$percent1)
{
$percent=$percent1;
#print $percent,"\t",$kmer_arr[$i],"\n";
$kmer=$kmer_arr[$i];
}
}
if($previous_percent<$percent)
{
$previous_kmer=$kmer;
$previous_percent=$percent;
}
else
{
break;
}
}
print $previous_kmer,"\t",$previous_percent;
