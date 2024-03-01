# FTrusts

## Overview
FTrusts is an addon that allows others to control your characters without them installing any addon whatsoever. By adding users to your whitelist, users can automate tasks for your characters by using party chat commands. You can control which commands are allowed, and who can make changes to your characters automations. 

## Features
- **Whitelist Management**: Allows players to add or remove other players from the whitelist.
- **Party Management**: Facilitates party management commands including transferring party lead, following commands, and more.
- **AutoAssist Management**: [Requires AutoAssist Addon](https://github.com/ekrividus/autoAssist) For all jobs, offers ability to auto assist a given player.
- **Singer Management**: [Requires Singer Addon](https://github.com/Ivaar/Windower-addons/tree/master/Singer) For Bard jobs, offers commands to manage singing buffs.
- **Autocor Management**: [Requires Autocor Addon](https://github.com/Ivaar/Windower-addons/tree/master/AutoCOR) For Corsair jobs, provides commands to manage rolling buffs.
- **Autogeo Management**: [Requires Autogeo Addon](https://github.com/Ivaar/Windower-addons/blob/master/AutoGEO/AutoGEO.lua) For Geomancer jobs, offers commands to manage geo spells.
- **Invisibility and Sneak Commands**: Automatically cast sneak or invisible spells for White Mage and Scholar jobs.
- **GUI Interface**: Includes a graphical user interface for easy configuration and status display.

## Installation
1. Ensure you have Windower installed and configured for Final Fantasy XI.
2. Create a folder within the `Windower4/addons` directory named `FTrusts`.
3. Place the `FTrusts.lua` file within the folder you just created.
4. From within the game, type `//lua load FTrusts`.
5. (Optional) If you'd like FTrusts loaded every time you start the game, include `lua load FTrusts` in your `init.txt` file found within `Windower/scripts` 

## Usage
- Type `/FT` or `/ftrusts` in the game chat to access addon commands.
- Use commands like `whitelist`, `autoinvite`, `corcommands`, `brdcommands`, `geocommands`, and `sneakinvis` followed by `on` or `off` to enable or disable features.
- Refer to the in-game help command (`//FT help`) for a comprehensive list of available commands.

## Commands
### Command List

- **Whitelist Management:**
  - Add to whitelist:
    - `/ft whitelist [add/+/a] name`
  - Remove from whitelist:
    - `/ft whitelist [remove/-/r] name`

- **Enable and Disable Automation:**
  - `/ft autoinvite [on/off]`
  - `/ft corcommands [on/off]`
  - `/ft brdcommands [on/off]`
  - `/ft geocommands [on/off]`
  - `/ft sneakinvis [on/off]`

- **Show/Hide the Ftrusts GUI:**
  - `/ft showgui [on/off]`

- **Party Management: (Type in party chat)**
  - `givelead name` - Transfer lead to named party member
  - `followme` - Player follows
  - `stopfollow` - Player will heal with delay then heal again to cancel follow

- **Party Invites: (Type in tell to party leader)**
  - `inviteme`

- **Singer Management: (Type in party chat) [Requires Singer addon]**
  - `stopsongs` - Brd will stop singing
  - `startsongs` - Brd will start singing
  - `missing song` - Brd will put a new buffersong
  - `fixclarion` - Brd will use Clarion call and restack 5th song

- **Autocor Management: (Type in party chat) [Requires Autocor addon]**
  - `stoprolls` - Cor will stop rolling
  - `startrolls` - Cor will start rolling
  - `sam and chaos` - Cor will change active rolls
  - `sam and cor` - Cor will change active rolls
  - `cor and chaos` - Cor will change active rolls

- **Autogeo Management: (Type in party chat) [Requires Autogeo addon]**
  - `startgeo` - Autogeo will turn on
  - `stopgeo` - Autogeo will turn off
  - `geo malaise` - Set Autogeo Geo spell to Malaise
  - `geo frailty` - Set Autogeo Geo spell to Frailty
  - `indi fury` - Set Autogeo Indi spell to Fury
  - `indi haste` - Set Autogeo Indi spell to Haste
  - `indi frailty` - Set Autogeo Indi spell to Frailty

- **Other Commands:**
  - `invis please` - Whm/Sch will cast AOE invis
  - `sneak please` - Whm/Sch will cast AOE sneak
  - `assiston` - Turns assist on
  - `assiststop` - Turns assist off
  - `assistme` - Sets player assist to whom entered command
  - `position` - Sets new position for autoassist, if return to position is on, reposition should be off but in case it's on
  - `foodup` - Will toggle gearswap autofood on, currently only works with silindrills luas

## Credits
- **Author**: Quenala
- **Version**: 2.2

## Disclaimer
This addon is created by the community and not officially supported by Square Enix. Use it at your own risk.
