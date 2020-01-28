
project=${PWD##*/}
allfile="/tmp/$project/$project.file.txt"
resfile="./golangci-lint_check_result"

echo
echo "project is $project"
echo

function read_dir(){
for file in `ls $1` #注意此处这是两个反引号，表示运行系统命令
do
 if [ -d $1"/"$file ] #注意此处之间一定要加上空格，否则会报错
 then
 read_dir $1"/"$file
 else
 echo $1"/"$file #在此处处理文件即可
 fi
done
} 


function start_check(){
  
  echo "golangci-lint run $1"
  echo
  golangci-lint run $1>>$resfile
  echo "check $1 end"
}

function killapp(){
  pid=` ps aux|grep golangci-lint|grep -v grep |awk '{print $2}'`
  if [ -n "$pid" ]; then 
      echo "kill the app who use golangci-lint"
      kill -9 $pid
  fi
}


function get_check_path(){
 rm -rf $allfile*
 mkdir -p /tmp/$project

 read_dir .>$allfile
 gofile=`cat $allfile |grep go |grep -v vendor|grep -v "_test"`

 for one in $gofile 
 do
   tmp=${one%/*}
   echo $tmp>>$allfile.path
 done
 
 cat $allfile.path|sort |uniq>$allfile.checkpath 
}


killapp
rm -rf $resfile

echo
echo "start checking...."
echo
get_check_path
checkpath=`cat $allfile.checkpath`
for k in $checkpath 
do
   echo $k
   start_check $k
done

cat $resfile |grep "go"|sed 's/:/ /g'|awk '{print $1" +"$2}'>num.txt
echo "check all end"
echo
cat num.txt

echo "-------------------------------------$project-------------------------------------">>$resfile
echo "                  this is for [ $project ]">>$resfile
echo "--------------------------------------------end----------------------------------------">>$resfile

rm -rf /tmp/r.go
cp $resfile /tmp/r.go

echo
echo "save check tmp path to /tmp/$project"
echo
echo "save check file to $resfile "
echo

