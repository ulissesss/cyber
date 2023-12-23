#!/bin/bash

#Take in input a shadow file
input="$1"
#From the shadow file takes only the users and hash passwords
n=$(cat "$input" | grep -v "*:$1.*" | grep -E '.{31,}' | wc -l)
#Create n files, every file has only one user and hash password
cat "$input" | grep -v "*:$1.*" | grep -E '.{31,}' | awk '{print > NR }'
wordlist=("rockyou.txt")
array=($(seq 1 $n))

#Use john to crack the passwords
for i in "${array[@]}"; do
       #echo "john --wordlist=$wordlist --format=crypt $i"
       john --wordlist=$wordlist --format=crypt $i > /dev/null 2>&1 &
done
wait
#echo "Command completed"
#Show the cracked passwords

for i in "${array[@]}"; do
    john -show $i > password_cracked.txt
done
for i in "${array[@]}"; do
    rm -rf $i
done
