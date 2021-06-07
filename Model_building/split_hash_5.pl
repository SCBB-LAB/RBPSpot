
open(FILE1,"5mer_list");
%hash;
while (<FILE1>)
{
  chomp;
  ($key, $val) = split /\t/;
  $hash{$key}=0;
}
close(FILE1);
for($i=0;$i<=150;$i++)
{
$tot=`wc -l $i|awk '{print $1}'`;
open(fh,$i);
while(<fh>)
{
chomp $_;
$hash{$_}++;
}
close(fh);
open(FILE1,"5mer_list");
open(fh2,">$ARGV[0]\_penta_Prob_value");
while (<FILE1>)
{
  chomp;
  ($key, $val) = split /\t/;
if($hash{$key}!=0)
{
$prob=$hash{$key}/$tot;
$rounded = sprintf("%.7f", $prob);
$final[$val][$i]= $rounded;
}
else
{
$final[$val][$i]= 0;}
}
}
for($m=0;$m<=16383;$m++)
{
for($n=0;$n<150;$n++)
{
print fh2 $final[$m][$n],"\t";
}
print fh2 $final[$m][$n],"\n";
}
for ($s=0;$s<=150;$s++)
{
`rm $s`;
}

