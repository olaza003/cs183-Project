#!/bin/sh
File="/root/cs183-Project/text.txt"
hold="/root/cs183-Project/holder.txt"
key="Spam" #keyword we are looking in the email

mailx -H | awk '{print $8, $9, $10, $11}' > "$File"

#after the subject stored we check if those are keywords
grep -n "$key" $File | awk -F":" '{print $1}' > "$hold"

while read -r line; do
last=$(tail -n 1 "$hold")
#echo "last is $last" 
echo $last | mail >> /root/cs183-Project/spam.txt
echo "d $last" | mail #deletes the mail according to whats the last line of the holder.txt
sed -i '$d' "$hold" #now it deletes the last line of the hold
done < "$hold"

#2nd part

mailx -H | awk '{print $8}' > "$File"
len=$(grep -c ^ $File)
mailnum=0 

while [ $mailnum -lt $len ]; do
mailnum=$(( mailnum+1 ))
echo " " > $hold
echo $mailnum | mail > $File
i=0 #0-false; 1-true
x=0 #counter
num=$(grep -c ^ $File)
num=$(( num-6 ))
	while read -r line; do
	   x=$(( x+1 ))
	   if [ $i == 0 ]; then 
		if [ $x -gt $num ]
		then
		 i=1
		fi
	   else
		echo "$line" >> $hold
	   fi
	done<"$File"

if grep -q $key /root/cs183-Project/holder.txt
then
  echo $mailnum | mail >> /root/cs183-Project/spam.txt
  echo "d $mailnum" | mail
fi
done
