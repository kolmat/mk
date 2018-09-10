#!/bin/bash -eu

#it will have always one element ""
removable=($(lsblk -o MOUNTPOINT,RM |egrep "[1]$" | awk ' $1 != 1   { print $1}') "")
option="nodev"
printf '%s\n' "${removable[@]}"

if [[ ${#removable[@]} -gt 1 ]]; then
	for dev in ${removable[@]}; do
		echo "${dev} is removable"
		if [[ -z $(findmnt -o OPTIONS ${dev}| grep -w ${option}) ]]; then 
			echo "FAIL"
			exit 1
		fi 
		echo "PASS"
		exit 0
	done
fi
echo "no removable dev"

