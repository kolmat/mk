#!/bin/bash -eu

#it will have always one element ""
removable=($(lsblk -o MOUNTPOINT,RM |egrep "[1]$" | awk ' $1 != 1   { print $1}') "")

printf '%s\n' "${removable[@]}"

if [[ ${#removable[@]} -gt 1 ]]; then
	for dev in ${removable[@]}; do
		echo "${dev} is USB"
		if [[ -z $(findmnt -o OPTIONS ${dev}| grep nodev) ]]; then 
			echo "FAIL"
			exit 1
		fi 
		echo "PASS"
		exit 0
	done
fi
echo "no removable dev"
