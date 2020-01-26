
path=`pwd`
cd $path

echo "find and vim:\"" $1 "\" " $2
echo
if [ -n "$2" ]; then 
        grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|head -$2|tail -1 |grep "$1" --color -n 
        count=`grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|head -$2|tail -1|wc -l` 
else 
        grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|grep "$1" --color -n 
        count=`grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|wc -l`
fi

if [ "$count" == "1" ]; then
	 if [ -n "$2" ]; then 
                str=`grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|grep "$1" --color -n |head -$2|tail -1` 
	 else 
	 	str=`grep -Rn "$1" *|grep -v "Binary file"|grep -v "vendor"|grep "$1" --color -n `
	 fi
	 file=`echo $str|sed 's/:/ /g'|awk '{print $2}'`
	 num=`echo $str|sed 's/:/ /g'|awk '{print $3}'`

	 echo  "open "$file" at line "$num 
	 echo
	 vim +$num $path/$file
else
	echo
	echo  $count" found in files"
fi

