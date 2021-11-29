#!/bin/sh
File="/root/cs183-Project/text.txt"
hold="/root/cs183-Project/holder.txt"
key="Spam" #keyword we are looking in the email

mailx -H | awk '{print $8, $9, $10, $11}' > "$File"

#after the subject stored we check if those are keywords
grep -n "$key" $File | awk -F":" '{print $1}' > "$hold"

while read -r line; do
last=$(tail -n 1 "$hold")
echo "last is $last" 
echo "d $last" | mail #deletes the mail according to whats the last line of the holder.txt
sed -i '$d' "$hold" #now it deletes the last line of the hold
done < "$hold"
