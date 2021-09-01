#/bin/sh
line=$(cat $1 | wc -l |awk -v v="$2" '{print int($1/v)}'|awk '{if($1%2==0) {print $0} else {print $0+1}}'  )
split -l $line $1 $1
ls $1?? | while read i ;do ./scan $3 $i $4 & ;done
