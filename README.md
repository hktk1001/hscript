# hscript

#全局字符串替换脚本：在当前目录遍历查找 aaa,将aaa替换为bbb

sh replace.sh "aaa"  "bbb"

#在当前目录查找，如找到只一条结果，用vim打开并跳到指定目录

sh find.sh ccc 

#如果找到多条结果,加上第二参数，指定打开第几个结果 

sh find.sh ddd 2
