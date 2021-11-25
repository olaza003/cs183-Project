#!/bin/sh
File="/root/cs183-Project/text.txt"
hold="/root/cs183-Project/holder.txt"
key="Spam" #keyword we are looking in the email

mailx -H | awk '{print $8, $9, $10, $11}' > "$File"

#after the subject stored we check if those are keywords
grep -n "$key" $File | awk -F":" '{print $1}' > "$hold"

