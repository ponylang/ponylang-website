# Arm Development with a Raspberry Pi 4

Our current resources for supporting Pony on Arm based systems is rather limited. This document details how to set up a Raspberry Pi 4 for use as a
Pony development system for addressing Arm issues.

## Hardware

This document is written assuming you will be doing headless development on a Pi and will ssh into the machine from another.

You'll need:

- Raspberry Pi 4 Model B with 8 gigs of memory: [purchase](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-8gb)
- Power supply: [purchase](https://www.raspberrypi.org/products/type-c-power-supply/)
- Case: [purchase](https://www.raspberrypi.org/products/raspberry-pi-4-case/)
- MicroSD with Raspbian installed.

You can purchase a MicroSD with a 32-bit Raspbian installed from all the Raspberry Pi resellers when you get the rest of your equipment. If you are doing 64-bit development, you'll have to install it yourself on to a MicroSD. Any MicroSD with at least 32 gigs of should be completely sufficient for development.

You'll also need:

A computer that has a MicroSD or SD reader/writer. Many computers come with builtin SD reader/writers. Most MicroSD cards that you purchase come with a MicroSD to SD adapter. If you purchase a MicroSD with Raspbian pre-installed, note that it does not come with an SD adapter.

The current SD card requirements are available on the [Raspberry Pi website](https://www.raspberrypi.org/documentation/computers/getting-started.html#sd-cards).

## Installing Raspbian on a microSD

If you didn't purchase a microSD with Raspbian installed, you'll need to download a Raspbian image and write it to your microSD using the [Raspberry Pi imager](https://www.raspberrypi.org/software/).

Raspbian downloads are available from the [Raspberry Pi downloads site](https://downloads.raspberrypi.org/).

For 32-bit installs you want to download a .zip image of [raspios_lite_armhf](https://downloads.raspberrypi.org/raspios_armhf/).

For 64-bit installs you want to download a .zip image of[raspbios_lite_arm64](https://downloads.raspberrypi.org/raspios_arm64/).

## Pre-boot Raspbian setup

These directions assume that you purchased a pre-installed Raspbian on a MicroSD. The directions should generally work if you using a different Raspbian, but haven't been tested with anything other than the version you can get as of September 2021.

### Turn on ssh access

See [this guide](https://phoenixnap.com/kb/enable-ssh-raspberry-pi) for turning on ssh access to your Pi.

### Turn on Wifi

To gain access to your headless machine to do additional configuration, you'll need to give it access to your wifi network. You turn on it on using a file called `wpa_supplicant.conf` that you will put in the same location you put the `ssh` file in the previous step.

See [this guide](https://www.raspberrypi-spy.co.uk/2017/04/manually-setting-up-pi-wifi-using-wpa_supplicant-conf/) for full instructions.

## Getting initial access

Once you have your Raspian install ready for its first booting, you'll want to put our MicroSD card in the MicroSD card slot on the underside of your Pi board and then put your board in it's case and plug it in. It should boot fairly quickly. Once it boots, it will get an IP address from your wifi router.

You'll need to use whatever tools your router provides to get the IP address of your Pi so you can ssh in as the user `pi`. The default password is `raspberry`.

## Post-boot configuration

Cmake is required so go ahead an install it:

- `sudo apt-get update --allow-releaseinfo-change`
- `sudo apt-get install cmake git`

At this time, you can't build Pony on a 32-bit Arm system using clang. Additionally, lldb doesn't appear to work in general. If you are working on solving either of those issues, go ahead an install them as well:

- `sudo apt-get install clang lldb`

### Additional configuration

Things you might want to do that are left to an exercise to the user:

- Change the `pi` user password
- Create your own user
- Setup access via ssh key rather than password
- Setup access via a static IP address
- Setup DNS
- Setup access via Ethernet
- Install your usual development tools

## Building pony

To build pony after you've cloned the source code, you'll follow the directions below. Note, because building with clang isn't currently supported, if you install `clang` you'll need to modify all the command below to build using `gcc` as the Pony build system defaults to using `clang` if it is available. To use `gcc`, you'd prepend `CC=/usr/bin/gcc CXX=/usr/bin/g++` to all the command below.

- `make libs build_flags="-j4"`

note, this will probably take about 3 hours. make sure you aren't logged out of ssh.

- `make configure`
- `make build -mtune=native`
- `make test`

See the [ponyc build instructions](https://github.com/ponylang/ponyc/blob/main/BUILD.md) for more information in general about building ponyc.
