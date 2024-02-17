#!/bin/bash

# shellcheck disable=SC2086
# shellcheck disable=SC2004
# shellcheck disable=SC2002
# shellcheck disable=SC2006
# shellcheck disable=SC2086

set -euox pipefail
SYS_CPUS=${1:-}

if [ "${SYS_CPUS}" == "" ]; then
  echo "Disabling cpu isolation if it is enabled."
  cset set -l -r
  system=`cset set -l -r | grep -o '/system' || true`
  user=`cset set -l -r | grep -o '/user' || true`
  if [ "${system}" != "" ]; then
    cset set --destroy system
  fi
  if [ "${user}" != "" ]; then
    cset set --destroy user
  fi
  cset set -l -r
  echo "Done disabling cpu isolation if it is enabled."
else
  old_sys_cpus=`cset set -l -r system | grep '/system$' | awk '{print $2}' || true`
  if [ "${old_sys_cpus}" == "${SYS_CPUS}" ]; then
    echo "SYS CPUS (${old_sys_cpus}) didn't change. Nothing to do."
    exit
  fi
  echo "Isolating general system processes to cpus '${SYS_CPUS}'."
  echo "Current process map by cpuset:"
  cset set -l -r
  mem_nodes=`cset set -l -r root | grep '/$' | awk '{print $4}'`
  cset set -c ${SYS_CPUS} -m ${mem_nodes} -s system
  sys_cpus=`cset set -l -r -x system | grep '/system$' | awk '{print $2}'`
  all_cpus=`cset set -l -r -x root | grep '/$' | awk '{print $2}'`
  user_cpus=$(( 0x${all_cpus} - 0x${sys_cpus} ))
  mask=0
  num_procs=$((`nproc --all`-1))
  user_cpuspec=""
  current_cpuspec_frag=""
  for (( bit=0; bit<${num_procs}; bit++)); do
    mask=$((1<<bit))
    if [ $((user_cpus&mask)) -eq 0 ]; then
      if [ "${current_cpuspec_frag}" != "" ]; then
        user_cpuspec=${user_cpuspec},${current_cpuspec_frag}-$((bit-1))
        current_cpuspec_frag=""
      fi
    else
      if [ "${current_cpuspec_frag}" == "" ]; then
        current_cpuspec_frag=${bit}
      fi
    fi
  done
  if [ "${current_cpuspec_frag}" != "" ]; then
    user_cpuspec=${user_cpuspec},${current_cpuspec_frag}-${bit}
  fi
  for (( bit=0; bit<${num_procs}; bit++)); do
    mask=$((1<<bit))
    if [ $((user_cpus&mask)) -ne 0 ]; then
      echo "Temporarily disabling user cpu: ${bit}"
      echo 0 > /sys/devices/system/cpu/cpu${bit}/online
    fi
  done
  sleep 1
  cat /proc/cpuinfo | grep proc
  for (( bit=0; bit<${num_procs}; bit++)); do
    mask=$((1<<bit))
    if [ $((user_cpus&mask)) -ne 0 ]; then
      echo "Re-enabling user cpu: ${bit}"
      echo 1 > /sys/devices/system/cpu/cpu${bit}/online
    fi
  done
  cset set -c ${user_cpuspec} -m ${mem_nodes} -s user
  cset proc -m -k --threads -f root -t system
  echo "Modified process map by cpuset:"
  cset set -l -r
  echo "Done isolating general system processes to cpus '${SYS_CPUS}'."
fi
