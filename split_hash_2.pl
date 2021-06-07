
open(FILE1,"7mer_list");
%hash;
while (<FILE1>)
{
  chomp;
  ($key, $val) = split /\t/;
  $hash{$key}=$val;
}
close(FILE1);


open(FILE2,"$ARGV[1]\_hepta_Prob_value");
@all_data;

while ( $linedata = <FILE2>) { 
   push # creates the next (n) slot(s) in an array
       @all_data
     , [ split '\t',$linedata ] 
       # ^ we're pushing an *array* not just additional elements.
      ; 
}
close(FILE2);

open(fh,"$ARGV[0]");
while(<fh>)
{
chomp $_;
if($_!~/>/)
{
for($i=0;$i<=150;$i++)
{
$str=substr  $_, $i, 7;
$b = uc $str;

$kmer= $hash{$b};
print $all_data[$kmer][$b],"\t";
}
print "\n";
}
}




