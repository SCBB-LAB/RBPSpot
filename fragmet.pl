#perl fragmet.pl fasta_file_of_positive_set
#perl split_hash.pl
#perl split_hash_2.pl positive_fasta >positive_output_file
#perl split_hash_2.pl negative_fasta >negative_output_file
open(fh,"$ARGV[0]");
while(<fh>)
{
chomp $_;
if($_!~/>|chr/)
{
for($i=0;$i<=150;$i++)
{
open(fm,">>$i");
$str=substr  $_, $i, 7;
$b = uc $str;
print fm $b,"\n";
close (fm);
}
}
}
