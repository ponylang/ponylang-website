# Performance Testing Setup

## Configuration

Notes on setting up a performance testing environment. This isn't guaranteed to be complete. This assumes:

- Single machine
- Ubuntu
- Not testing networking

Specific instructions will vary based on your particular Linux version.

### Turn off hyperthreading

This is usually in the BIOS. Some machines will let you turn if off via kernel boot parameters (`noht`), but to be sure, it is best to turn it off in the BIOS.

### isolcpus

When doing testing, we want to isolate all "system processes" on a single CPU. We don't want this set when compiling ponyc as it will take a long time to build LLVM with only 1 CPU.

Setting up only a single CPU for the system when testing will allow us to use cset to allow the test application to run without interference.

In `/etc/default/grub`:

`GRUB_CMDLINE_LINUX="isolcpus=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"`

where the comma separated list is all the CPUs to remove from usage by the system. In the example above, the machine has 16 real cores and all of them but `0` have been set aside for application testing.

When compiling etc, you want to set remove the `isolcpus`:

`GRUB_CMDLINE_LINUX=""`

For grub changes to take effect you need to update the grub config and reboot:

```bash
sudo grub-update
sudo reboot
```

You can see what CPUs (if any) are isolated:

```bash
cat /sys/devices/system/cpu/isolated
```

### Set the scaling governor

Modern CPUs have powerscaling on CPUs. CPUs being run at lower clocks speeds during a test run can mess with results. To protect against that, we set the scaling governor to `performance`:

```bash
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

To see what calling governor is set for each CPU, you can run:

```bash
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

Note this will be reset each time you reboot.

### CPU Turbo

If your CPU supports a "Turbo" function that can temporarily give a clock boost, you should learn how to turn it off.

### tsc=reliable

Add `tsc=reliable` to grub parameters.

### Swappiness

```bash
sudo sysctl -w vm.swappiness=0
```

Gets cleared on reboot. Can be set permanently in `/etc/sysctrl.conf`.

### Transparent huge pages

Turn off transparent huge pages by adding `transparent_hugepage=never` to grub parameters.

### Latency settings and others

Most of these you can learn about [here](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html?highlight=kernel%20parameters).

Add the following grub parameters:

- `skew_tick=1`
- `rcupdate.rcu_normal=1`
- `rcutree.kthread_prio=50`
- `workqueue.power_efficient=0`
- `idle=nomwait`
- `audit=0`
- `nosoftlockup=0`

## Scripts

We've got a few scripts that can help automate some of the above.

- [setup.bash](performance-testing-scripts/setup.bash)
- [create-cpu-shield.sh](performance-testing-scripts/create-cpu-shield.sh)
- [verify.bash](performance-testing-scripts/verify.bash)
