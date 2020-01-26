
if [ -z "$1" ]; then 
	echo "param 1 is empty"
	exit 1 
fi

if [ -z "$2" ]; then 
	echo "param 2 is empty"
	exit 2 
fi

echo
echo "Replace "$1" to "$2" in files:"
grep -Rn "$1" *|grep -v "Binary file"|sed 's/:/ :/g'|grep "$1"  --color -rn
echo 
echo "Start replacing...."
echo
grep -Rn "$1" *|grep -v "Binary"| sed "s/:/ /g"|awk '{print $1}'|sort | uniq |grep -v grep|xargs sed -i "s:$1:$2:g"
echo
echo "Done ^_^ "
echo

