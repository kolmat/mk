#!/bin/bash -eu

time='1'
find_log='/var/find.log'
find_log_new='/var/find.new'

get_lock (){
  exec 200>/var/lock/.myscript.exclusivelock
  flock -n 200  && return 0 || return 1
}

eexit() {
    local error_str="$@"

    echo $error_str
    exit 1
}
print_find (){
  cat $find_log
  exit 0
}

search(){
  $(find / -type d -perm 0777 -exec \
    stat --format=%n:%a {} + > "$find_log_new")
}

set +e
find "${find_log}" -mmin +"${time}" | egrep '.*'
RET=$?
set -e
echo "${RET}"

if [[ ! -f "${find_log}" ]] || [[ "${RET}" == '0' ]]; then 
  echo "plik nie istnieje albo jest juz za stary "
  # If lock return 1 jump to print_find and pront old file 
  # if lock is 0 then re-run find and then print findings
  
  get_lock || print_find 
  search
  cp $find_log_new $find_log
  print_find

elif [[ "${RET}" == '1' ]]; then
  echo "plik nie ma jesscze ${time} min"
  print_find
fi
