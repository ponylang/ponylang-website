#!/bin/bash

# shellcheck disable=SC2002

CPU_GOV=$(cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor)
CLOCKSOURCE=$(cat /sys/devices/system/clocksource/clocksource0/current_clocksource)
TSC_RELIABLE=$(cat /proc/cmdline | grep -o tsc=reliable)
SWAPPINESS=$(sysctl -n vm.swappiness)
THP=$(cat /sys/kernel/mm/transparent_hugepage/enabled | awk -F[ '{print $2}' | awk -F] '{print $1}')

if [ "performance" != "${CPU_GOV}" ]; then
  if [ "" == "${CPU_GOV}" ]; then
    echo -e "\033[01;31mWARNING: CPU governor not under our control which is not ideal!\033[0m"
  else
    echo -e "\033[01;31mWARNING: CPU governor is '${CPU_GOV}' which is not ideal!\033[0m"
  fi
else
  echo -e "\033[01;32mCPU governor is set up correctly (${CPU_GOV}) for optimal performance.\033[0m"
fi

if [ "tsc" != "${CLOCKSOURCE}" ]; then
  echo -e "\033[01;31mWARNING: system clocksource is '${CLOCKSOURCE}' which is not ideal! It should be 'tsc'.\033[0m"
else
  echo -e "\033[01;32mSystem clocksource is set up correctly for optimal performance.\033[0m"
fi

if [ "" == "${TSC_RELIABLE}" ]; then
  echo -e "\033[01;31mWARNING: tsc clocksource isn't set as reliable which is not ideal because the system might mark tsc as unreliable!\033[0m"
else
  echo -e "\033[01;32mtsc clocksource is set as reliable correctly for optimal performance.\033[0m"
fi

if [ "0" != "${SWAPPINESS}" ]; then
  echo -e "\033[01;31mWARNING: swappiness is not 0 which is not ideal! It is set to '${SWAPPINESS}' instead of '0'.\033[0m"
else
  echo -e "\033[01;32mSwappiness is set to 0 as required for optimal performance.\033[0m"
fi

if [ "never" != "${THP}" ]; then
  echo -e "\033[01;31mWARNING: transparent hugepages is not disabled which is not ideal! It is set to '${THP}' instead of 'never'.\033[0m"
else
  echo -e "\033[01;32mTransparent hugepages is disabled as required for optimal performance.\033[0m"
fi
