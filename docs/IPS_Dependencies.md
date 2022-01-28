# Patch dependencies
This may change in the future, the basic idea here is to have "strict" rules to allow multiple person edit part of the ROM without overriding one another, which is possible when it remains in the same data region which can't be the case for everything. The best would be having a complete disassembly but for now it works...

## Table of contents

- [Dependency graph](#dependency-graph)
- [Patch names](#patch-names)

## Dependency graph

![IPS Dependency](docs/IPS%20Dependency.jpg)

## Patch names

- `00-vanilla`: Represents the vanilla ROM with no changes
- `01-worldmap`: Contains the world map *including the entrance triggers & **event/npc triggers positioning only**
  - `0x-maps` : *TODO* Would contains every other maps? Or maybe divided by region?
- `02-vehicles`: Contains all changes related to the vehicles
- `03-items`: *TODO* Contains all changes related to item properties
- `04-monsters`: Contains all changes related to monster properties
  - `0x-dropTable`: *TODO* Contains all changes related to drop table of monsters
  - `0x-formations`: *TODO* Contains all changes related to monster battle formations
    - `0x-enemyMapping`: *TODO* Contains all changes related to battle formations mapping
    - `0x-treasureMapping`: *TODO* Contains all changes related to battle formations mapping with treasures *including complete treasure trigger*
- `05-skills`: *TODO* Contains all changes related to skill properties
  - `0x-enemySkills`: *TODO* Contains all changes related to enemy skills
  - `0x-charSkills`: *TODO* Contains all changes related to character skills
- `06-characters`: Contains all changes related to character properties
- `08-events`: Contains all changes related to event triggers
- `99-devRoom`: Contains developper room with custom event to debug in-game
