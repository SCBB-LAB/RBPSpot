
open(fh,"$ARGV[0]");
$prob=($ARGV[1]*1.0)-1;

while(<fh>)
{
chomp $_;
if($_!~/\>/)
{
$arm=$_;

for($i=0;$i<=length($arm)-$ARGV[1];$i++)
{
%data = ('AA', 0, 'AC', 0, 'AG', 0, 'AT', 0, 'CA', 0, 'CC', 0, 'CG', 0, 'CT', 0, 'GA', 0, 'GC', 0, 'GG', 0, 'GT', 0, 'TA', 0, 'TC', 0, 'TG', 0, 'TT', 0);
$str=substr  $arm, $i, $ARGV[1];
#print $str,"\n";
for($j=0;$j<=length($str)-2;$j++)
{$str1="";
$str1=substr  $str, $j, 2;
#print $str1,"\t";
$data{$str1}++,"\n";
}
printf ("%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t",$data{'AA'}/$prob,$data{'AC'}/$prob,$data{'AG'}/$prob,$data{'AT'}/$prob,$data{'CA'}/$prob,$data{'CC'}/$prob,$data{'CG'}/$prob,$data{'CT'}/$prob,$data{'GA'}/$prob,$data{'GC'}/$prob,$data{'GG'}/$prob,$data{'GT'}/$prob,$data{'TA'}/$prob,$data{'TC'}/$prob,$data{'TG'}/$prob,$data{'TT'}/$prob);

}
print "\n";
}
}
