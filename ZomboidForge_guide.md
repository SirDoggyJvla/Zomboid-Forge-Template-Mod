# Introduction
This guide is dedicated to the mod Zomboid Forge which is a framework that I created to easily add custom zombies to the game while still being compatible with other mods. There are limitations to this compatibility however as changing zombie sounds using .bank files or textures etc might render the mod incompatible with other Zomboid Forge addons.

At the end of the day, it's your creativity that matters and my framework is mostly here to give tools to modders for easy implementation of zombies by utilizing an optimized framework which handles all the stats of zombies and when to trigger specific updates to the zombies.



# Table of Contents
- [Introduction](#introduction)
- [Table of Contents](#table-of-contents)
- [Mod template and external links / tools](#mod-template-and-external-links--tools)
- [Creating a zombie type](#creating-a-zombie-type)
- [Base informations](#base-informations)
  - [Name of the zombie](#name-of-the-zombie)
- [Nametag color](#nametag-color)
- [Spawn weight](#spawn-weight)
- [Setting a ZType stats](#setting-a-ztype-stats)
  - [Generic stats](#generic-stats)
  - [Health stat](#health-stat)

# Mod template and external links / tools
The full Zomboid Forge project is available on Github:
https://github.com/SirDoggyJvla/Zomboid-Forge

The complete template mod can be found at this Github link:
https://github.com/SirDoggyJvla/Zomboid-Forge-Template-Mod

# Creating a zombie type

A zombie type within the framework is usually referenced as **ZType**. They are added within a table, linked to a key and is accessed by the framework using this key when a zombie type is attributed.

Let's consider a first example of custom zombie being a very strong zombie with max stats and nothing else special about it. The key associated to this zombie will be `StrongZomboid`.

Our ZType is added to the table `ZomboidForge.ZTypes` which can be accessed by importing the Zomboid Forge `module` within a Lua file in `media/lua/client/filename.lua` (in the template: `ZF_Template.lua`):
```lua
local ZomboidForge = require "ZomboidForge_module"

ZType_data = {
    ...
}
ZomboidForge.ZTypes.StrongZomboid = ZType_data
```

`zombie_stats` needs to be a table and any information related to your zombie type will be available within this table. It is accessed by the framework based on keys which we will define in the next sections.

It is highly suggested to add your ZType at `OnGameStart` this way:
```lua
local ZomboidForge = require "ZomboidForge_module"

local function Initialize_ZF_Template()
    ZomboidForge.ZTypes.StrongZomboid = {
        ...
    }
end

Events.OnGameStart.Add(Initialize_ZF_Template)
```

The framework will access the ZType data whenever it needs to do actions with them like update the zombie stats which is done every 10 seconds for less than ~400 zombies. This means at anytime, you can write a function that will modify the ZType data. You can definitely find a use for that but the most used is probably just adding new functions after defining the data, like for later access with sandbox options (this is detailed in a later section).


# Base informations

In this part I will define data keys you can use to set the name of a zombie and it's spawn weight.

## Name of the zombie
A nametag is displayed above a zombie if the sandbox options were set to allow it or a client allows it within its mod options. The way this is done is by adding a `name ` key to our ZType data:
```lua
ZType_data = {
    ...
    name = "Strong Zomboid",
    ...
}
```
`name` needs to be a `string` and in this case we've set it to `Strong Zomboid` which will be the nametag of the zombie. But you can utilize the translation system of Project Zomboid by defining a name within `media/lua/shared/Translate/language/IG_UI_language.txt`. For example:
```lua
-- media/lua/shared/Translate/EN/IG_UI_EN.txt
IGUI_EN = {
    -- Template Zomboids names
	IGUI_ZF_StrongZomboid = "Strong Zomboid",
}
```
```lua
-- media/lua/shared/Translate/FR/IG_UI_FR.txt
IGUI_FR = {
    -- Noms des Zomboids modèles
	IGUI_ZF_StrongZomboid = "Zomboid Fort",
}
```
And by defining `name` this way:
```lua
-- back to the .lua file
ZType_data = {
    ...
    name = "IGUI_ZF_StrongZomboid",
    ...
}
```
The framework will retrieve the name of the zombie by utilizing `IGUI_ZF_StrongZomboid`. 

# Nametag color


# Spawn weight


# Setting a ZType stats

Many options exists for a ZType data and the main ones are simply zombie lore stats. 7 stats are overwritten by the mod and sadly you are obligated to overwrite them and give values for those.
The reason you need to do that is that the stats of zombies are updated by modifying the base sandbox options from the Lua and reload the zombie stats by making it `inactive` and `active` again.

If you don't specify a value for a stat, your zombie will take the last sandbox option value so it will base itself on the last updated zombie. You can definitely do some fancy stuff with this but overall I would suggest you set a value or the randomness of the stats of the ZType will depend on the addons a player has.

## Generic stats
The 7 stats and their possible values are:

|   Stat    |  Table Key  |         `1`          |      `2`      |       `3`        |   `4`   |
| :-------: | :---------: | :------------------: | :-----------: | :--------------: | :-----: |
| Walktype  | `walktype`  |       Sprinter       | Fast Shambler |     Shambler     | Crawler |
| Strength  | `strength`  |      Superhuman      |    Normal     |       Weak       |         |
| Toughness | `toughness` |        Tough         |    Normal     |     Fragile      |         |
| Cognition | `cognition` | Navigate + Use Doors |   Navigate    | Basic navigation |         |
|  Memory   |  `memory`   |         Long         |    Normal     |      Short       |  None   |
|   Sight   |   `sight`   |        Eagle         |    Normal     |       Poor       |         |
|  Hearing  |  `hearing`  |       Pinpoint       |    Normal     |       Poor       |         |

To set the stats, simply add the `key = value`. If we take back our `ZType_data` table and chose the stats for our Strong Zomboid:

```lua
ZType_data = {
    ...
    walktype = 1,
    strength = 1,
    toughness = 1,
    cognition = 1,
    memory = 1,
    sight = 1,
    hearing = 1,
    ...
}
```
This means our Strong Zomboid will be a superhuman sprinter, tough with eagle sight and pinpoint hearing while able to remember a target for a long time and open doors.

**It is important to note that cognition stat is a lie and `Navigate = Basic navigation`. The base game doesn't make the difference between both so having `cognition = 2` is the same thing as having `cognition = 3`.**

## Health stat
The last stat we can define is the health of the ZType. By utilizing the key `HP` with a value different than `1`, the framework will override the health system and apply a special one for the zombie. As such, in our Strong Zomboid example we can make the ZType have 20 times health this way:
```lua
ZType_data = {
    ...
    HP = 20,
    ...
}
```

