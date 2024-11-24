# Build
Since rom hacking is playing a lot with raw assembly and binary, we need to rebuild a lot, and instead of doing it manually every time, I tend to automate some of the steps. 

## Table of contents

- [Overview](#overview)
- [Build config files](#build-config-files)
- [Apply scripts](#apply-scripts)
- [Build scripts](#build-scripts)

## Overview

```text
apply.bat
└─ ips-patcher.bat

apply-deps.bat
└─ build-deps.bat
   └─ ips-patcher.bat

build.bat
├─ backup-rom.bat
├─ build-deps.bat
│  └─ ips-patcher.bat
├─ patch.bat
│  ├─ asm-patcher.bat
│  └─ ips-patcher.bat
└─ build-ips.bat
   └─ ips-creator.bat
```

## Build config files

The main objective of these files is to ease the building process by grouping every patches under each and every patch name OR group.

There are four config files as of now :

- `build-config-asm.ini`: Contains an **ordered list** of ASM patches to apply with Asar
- `build-config-ips.ini`: Contains an **ordered list** of IPS patches to apply with Flips
  > The reason there are IPS patches that are applied is because there are still changes that aren't in pure assembly code, so they are edited using some of the tools described on the main [README](../README.md)
- `build-deps.ini`: Contains an **ordered list** of patches with their dependencies
- `apply-config.ini`: Contains an **ordered list** of patches to apply with Flips

Sample for `build-config-ips|asm.ini`:
```text
[0x-patchName]

[0x-patchName2]
patch-1.ips
patch-2.ips
patch-3.ips
```
```text
[0x-patchName]

[0x-patchName2]
patch-1.asm
patch-2.asm
patch-3.asm
```

Sample for `build-deps.ini`:
```text
[0x-patchName]

[0x-patchName2]
0x-patchName

[0x-patchName3]
0x-patchName
0x-patchName2
```

Sample for `apply-config.ini`:
```text
[default]
0x-patchName
0x-patchName2
0x-patchName3

[dev]
xx-dev-patchName
```

## Apply scripts

### apply.bat

This script will copy the vanilla ROM and applies every named patches from the `patches` folder. Also, there is a flag option to allow or not Developer mode.

#### Args

1. Vanilla ROM which we want to apply the patches
2. \[optional\] Flag option to add a specific patch. If specified, only valid value : `-dev`

#### How to use

```powershell
apply.bat rom.sfc|rom.smc
apply.bat rom.sfc|rom.smc -dev
```

### apply-deps.bat

This script will copy the vanilla ROM, reads the dependencies config files, loops on every line under each patch name and calls the IPS patcher. Also, there is a flag option to allow or not Developer mode.

#### Args

1. Vanilla ROM
3. \[optional\] Flag option to add a specific patch. If specified, only valid value : `-dev`

#### How to use

```powershell
apply-deps.bat rom.sfc|rom.smc
apply-deps.bat rom.sfc|rom.smc -dev
```

## Build scripts

### build-all.bat

This script reads the build config file, loops on every specified patch name and calls the `build.bat` script.

#### Args

1. Vanilla ROM which we want to apply the patches

#### How to use

```powershell
build-all.bat rom.sfc|rom.smc
```

### build.bat

There are two modes to this script :
- backup the vanilla ROM, build the patch dependencies, apply the IPS patches, apply the ASM patches and create the final IPS patch
- create an IPS patch based on an already hacked ROM

#### Args

1. Patch name that represent the resulting IPS patch
2. Vanilla ROM which we want to apply the patches
3. \[optional\] Hacked ROM which we want to create the IPS patch

#### How to use

```powershell
build.bat 0x-patchName rom.sfc|rom.smc
build.bat 0x-patchName rom.sfc|rom.smc hacked.sfc|hacked.smc
```

### backup-rom.bat

It takes the original ROM, make a copy of it with a suffix based on the date and time of the day (ex.: `0x_patchName_YYYY_MM_DD__HH_MM_SS.sfc|smc`) and put it in the `build/tmp` folder.

#### Args

1. Returns the complete path to the temporary ROM
2. Vanilla ROM
3. Patch name

#### How to use

```powershell
backup-rom.bat returnValue rom.sfc|rom.smc 0x-patchName
```

### build-deps.bat

This script reads the dependencies config files, loops on every line under the specified patch name and calls the IPS patcher.

#### Args

1. Vanilla ROM
2. Patch name
3. Config file name to use

#### How to use

```powershell
build-deps.bat rom.sfc|rom.smc 0x-patchName build-deps.ini
```

### patch.bat

This script reads the build config files, loops on every line under the specified patch name and calls the patcher according to the specified kind. 

#### Args

1. Kind of patches to use. Two valid values : `asm` or `ips`
2. Vanilla ROM
3. Patch name
4. Config file name to use

#### How to use

```powershell
patch.bat asm rom.sfc|rom.smc 0x-patchName build-config-asm.ini
patch.bat ips rom.sfc|rom.smc 0x-patchName build-config-ips.ini
```

### asm-patcher.bat

Apply the ASM patches to a ROM.

#### Args

1. Vanilla ROM
2. ASM Patch filename
3. Patch name

#### How to use

```powershell
asm-patcher.bat rom.sfc|rom.smc patch-1.asm 0x-patchName
```

### ips-patcher.bat

Apply the IPS patches to a ROM.

#### Args

1. Vanilla ROM
2. Patch name

#### How to use

```powershell
ips-patcher.bat rom.sfc|rom.smc 0x-patchName.ips
```

### build-ips.bat

Creates an IPS patch from an hacked ROM and save it with a suffix based on the date and time of the day (ex.: `0x_patchName_YYYY_MM_DD__HH_MM_SS.ips`) and put it in the `patches/tmp` folder.

#### Args

1. Vanilla ROM
2. Hacked ROM which we want to create the IPS patch
3. Patch name

#### How to use

```powershell
build-ips.bat rom.sfc|rom.smc hacked.sfc|hacked.smc 0x-patchName
```

### ips-creator.bat

Create an IPS patch from the specified ROMs.

#### Args

1. Vanilla ROM
2. Hacked ROM which we want to create the IPS patch
3. Patch name
4. Patches folder

#### How to use

```powershell
ips-creator.bat rom.sfc|rom.smc hacked.sfc|hacked.smc 0x-patchName ../patches/tmp
```
