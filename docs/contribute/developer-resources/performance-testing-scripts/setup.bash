#!/bin/bash

echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

sudo sysctl -w vm.swappiness=0
