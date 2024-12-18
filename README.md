# snes-ffci
Final Fantasy C1 is an attempt to become a Super NES ROM hack that remixes elements of Final Fantasy IV to relive Final Fantasy I on the Super NES.

This project is *NOT* endorsed by [Square Enix](https://www.square-enix.com/). All assets from the original Final Fantasy IV (images, music, sound effects, characters, dialogs, story elements, etc.) are copyrights of [Square Enix](https://www.square-enix.com/). I claim no ownership of any of the assets from the original game.

## Table of contents

- [History](#history)
- [Quick start](#quick-start)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Acknowledgments](#acknowledgments)

## History

I started playing [FF4 : Free Enterprise](http://ff4fe.com/) for some years now (you should go check it out, the community is awesome!) Someday, some friends and I was discussing the idea of an "Open World" randomizer with Paladin's Quest (or Lennus) on the SNES. Having no real experience in rom hacking, it was too big of a project to starts with (even if we still have some notes laying around). Taking a break from it, I found out about [Final Fantasy C2](https://www.romhacking.net/hacks/5298/) which I played through and found pretty interesting. When COVID started, the idea of rom hacking came back and looking through the many resources there are on Final Fantasy IV, this was an easier project to handle. Thus, Final Fantasy C1 was born, to relive Final Fantasy I on the Super NES.

## Quick start

### Initial Setup

- Get the ROM (You are on your own).
- Download [Asar](https://github.com/RPGHacker/asar) and put it in the `build/tools/asar` folder
- Download [Flips](https://www.romhacking.net/utilities/1040/) and put it in the `build/tools/flips` folder

### Apply the patches

- Go to the main folder of this repo.
- Run this command to apply every patch to your ROM.
  ```powershell
  apply.bat rom.sfc|rom.smc [dev]
  ```
  > If you add the `dev` option, it will add the `devRoom` patch.

### Build the patches
 
> Every patched ROMs and/or IPS patches created during the building phase are stored into `build/tmp` and `patches/tmp` accordingly with a suffix based on date and time of the day.  
> You will however need to move the builded patches in the `patches` folder, removes the suffix and then to run the `apply.bat` above to apply them to a ROM.

- Go into the `build` folder of this repo.
- Run this command to build all patches based on your ROM.
  ```powershell
  build-all.bat rom.sfc|rom.smc [dev]
  ```
  > If you add the `dev` option, it will build the `devRoom` patch.

OR

- Run this command to build a specific patch based on your ROM.
  ```powershell
  0x-patchName.bat rom.sfc|rom.smc
  ```

OR

- Run this command to create an IPS patch from an already hacked ROM.
  ```powershell
  0x-patchName.bat rom.sfc|rom.smc hacked.sfc|hacked.smc
  ```

## Documentation

### Project Structure

The general project structure is as follows:

- `build`: Scripts to build every patch independently or all of them
   - `tools`: Work directory for tools that are used by the build scripts (ex.: Asar and Flips)
   - `tmp`: Generated by the build scripts, it will contains the temporary patched roms before creating the IPS patches
- `config`: Custom configuration used for some of the tools (ex.: FF6Tools, YYCHR.NET, etc.)
- `docs`: General documentation of this code base, may have hacking notes and other things
- `patches`: Pre-compiled IPS patches
   - `tmp`: Generated by the build scripts, it will contains the temporary IPS patches created
- `sprites`: Edited sprites (*I repeat, I claim no ownership of any of the assets*), grouped by IPS patch
- `src`: Assembler source code, grouped by IPS patch

### Patch dependencies

This may change in the future, the basic idea here is to have "strict" rules to allow multiple person edit part of the ROM without overriding one another, which is possible when it remains in the same data region which can't be the case for everything. The best would be having a complete disassembly but for now it works...

![IPS Dependency](docs/IPS%20Dependency.jpg)

For more in-depth details, you can [go further within the docs](docs/IPS_Dependencies.md)

### Build script dependencies

Since rom hacking is playing a lot with raw assembly and binary, we need to rebuild a lot, and instead of doing it manually every time, I tend to automate some of the steps. 

```text
apply.bat
└─ ips-patcher.bat

build.bat
├─ backup-rom.bat
├─ patch.bat
│  ├─ asm-patcher.bat
│  └─ ips-patcher.bat
└─ build-ips.bat
   └─ ips-creator.bat
```

For more in-depth details, you can [go further within the docs](docs/Build.md)

## Contributing

Still in development...

## Acknowledgments

These awesome people contributed indirectly to this project by posting their knowledge about the game through Discord/Hacking forums and/or by creating comprehensive tools to ease the exploration within the bolts and bits of the game.

- Slick Productions forum : <https://web.archive.org/web/20200414113643/http://slickproductions.org/forum/index.php?board=13.0>
- FF6Tools : <https://github.com/everything8215/ff6tools>
- FF4kster : <https://github.com/pinkpuff/ff4kster>
- DiztinGUIsh : <https://github.com/Dotsarecool/DiztinGUIsh>
- YY_CHR.NET : <https://www.romhacking.net/utilities/958/>
- Floating IPS : <https://www.romhacking.net/utilities/1040/>
- Asar : <https://github.com/RPGHacker/asar>
- Geiger's Snes9x Debugger : <https://www.romhacking.net/utilities/241/>
- 65c816 Op codes Tutorial : <http://www.6502.org/tutorials/65c816opcodes.html>
- 65c816 Reference : <https://wiki.superfamicom.org/65816-reference>
- HxD : <https://mh-nexus.de/en/hxd/>

All tools referenced are released under their own respective licenses.
