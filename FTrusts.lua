_addon.name = 'FTrusts'
_addon.version = '2.2'
_addon.author = 'Quenala'
_addon.commands = {'FT','ftrusts'}

-- Adjust the position of the window:
PosisionX = 1000
PositionY = 300

-- Set prefered default values [on/off]:
showgui = "on"
autoinvite = "on"
brdcommands = "on"
corcommands = "on"
geocommands = "on"
sneakinvis = "on"
SingleBuffer = "Army's Paeon" 

-- Do not change anything else
require('luau')
texts = require('texts')

defaults = T{}
defaults.mode = 'whitelist'
defaults.whitelist = S{}

aliases = T{
    wlist = 'whitelist',
    whitelist = 'whitelist',
	wl = 'whitelist',
    showgui = 'commandsetting',
    autoinvite = 'commandsetting',
    corcommands = 'commandsetting',
    brdcommands = 'commandsetting',
    geocommands = 'commandsetting',
    sneakinvis = 'commandsetting',
}

addstrs = S{'a', 'add', '+'}
rmstrs = S{'r', 'remove', '-'}
commandoptions = S{'on', 'off'}
modes = S{'whitelist'}

jobinfo = windower.ffxi.get_player()
mainjob = jobinfo.main_job
subjob = jobinfo.sub_job
settings = config.load(defaults)



function add_item(mode, ...)
	settings = config.load(defaults)
    local names = S{...}
    local doubles = names * settings[mode]
    if not doubles:empty() then
        notice('User':plural(doubles)..' '..doubles:format()..' already on '..aliases[mode]..'.')
    end
    local new = names - settings[mode]
    if not new:empty() then
        settings[mode] = settings[mode] + new
        log('Added '..new:format()..' to the '..aliases[mode]..'.')
		config.save(settings)
    end
end

function remove_item(mode, ...)
	settings = config.load(defaults)
    local names = S{...}
    local dummy = names - settings[mode]
    if not dummy:empty() then
        notice('User':plural(dummy)..' '..dummy:format()..' not found on '..aliases[mode]..'.')
    end
    local item_to_remove = names * settings[mode]
    if not item_to_remove:empty() then
        settings[mode] = settings[mode] - item_to_remove
        log('Removed '..item_to_remove:format()..' from the '..aliases[mode]..'.')
		config.save(settings)
    end
end

windower.register_event('addon command', function(command, ...)
    command = command and command:lower() or 'status'
    local args = L{...}
	
    if aliases:keyset():contains(command) then
        mode = aliases[command]
        names = args:slice(2):map(string.ucfirst..string.lower)
        if args:empty() then
            log(mode:ucfirst()..':', settings[mode]:format('csv'))
        else
            if addstrs:contains(args[1]) then
                add_item(mode, names:unpack())
            elseif rmstrs:contains(args[1]) then
                remove_item(mode, names:unpack())
            elseif commandoptions:contains(args[1]) then
                if command == 'autoinvite' then
                    notice('Autoinvite is turned '..args[1])
                    autoinvite = args[1]
                    Ftrusts_jobbox:text(Ftrusts_box())
                elseif command == 'brdcommands' then
                    notice('Brdcommands is turned '..args[1])
                    brdcommands = args[1]
                    Ftrusts_jobbox:text(Ftrusts_box())
                elseif command == 'corcommands' then
                    notice('Corcommands is turned '..args[1])
                    corcommands = args[1]
                    Ftrusts_jobbox:text(Ftrusts_box())
                elseif command == 'sneakinvis' then
                    notice('Sneak/invis is turned '..args[1])
                    sneakinvis = args[1]    
                    Ftrusts_jobbox:text(Ftrusts_box())
                elseif command == 'showgui' then
                    notice('GUI is turned '..args[1])
                    if args[1] == 'off' then
                        Ftrusts_jobbox:hide()
                    else
                        Ftrusts_jobbox:show()
                    end
                    Ftrusts_jobbox:text(Ftrusts_box())
                end
            else
                notice('Invalid operator specified. Specify add or remove.')
            end
        end
        
    elseif command == 'help' then
        notice('Commandlist:.')
        notice('--------------------------------------------------------------------------')
        notice('Add to whitelist:')
        notice('//ft whitelist [add/+/a] name')
        notice('Remove from whitelist::')
        notice('//ft whitelist [remove/-/r] name')
        notice('--------------------------------------------------------------------------')
        notice('Enable and disable automation:')
        notice('//ft autoinvite [on/off]')
        notice('//ft corcommands [on/off]')
        notice('//ft brdcommands [on/off]')
        notice('//ft geocommands [on/off]')
        notice('//ft sneakinvis [on/off]')
        notice('--------------------------------------------------------------------------')
        notice('Show/Hide the Ftrusts GUI')
        notice('//ft showgui [on/off]')
        notice('--------------------------------------------------------------------------')
        notice('Party management: (Type in party chat)')
        notice('givelead name       -Transfer lead to named party member')
        notice('followme            -player follows-')
        notice('stopfollow          -player will heal with delay then heal again to cancel follow')
        notice('--------------------------------------------------------------------------')
        notice('Party invites (type in tell to party leader)')
        notice('inviteme')
        notice('--------------------------------------------------------------------------')
        notice('Singer management: (Type in party chat) [Requires Singer addon]')
        notice('stopsongs           -Brd will stop singing.')
        notice('startsongs          -Brd will start singing')
        notice('missing song        -Brd will put a new buffersong')
        notice('fixclarion          -Brd will use Clarion call and restack 5th song')
        notice('--------------------------------------------------------------------------')
        notice('Autocor management: (Type in party chat) [Requires Autocor addon]')
        notice('stoprolls           -Cor will stop rolling')
        notice('startrolls          -Cor will start rolling')
        notice('sam and chaos       -Cor will change active rolls')
        notice('sam and cor         -Cor will change active rolls')
        notice('cor and chaos       -Cor will change active rolls')
        notice('--------------------------------------------------------------------------')
        notice('Autogeo management: (Type in party chat) [Requires Autogeo addon]')
        notice('startgeo            -Autogeo will turn on')
        notice('stopgeo             -Autogeo will turn off')
        notice('geo malaise         -Set Autogeo Geo spell to Malaise')
        notice('geo frailty         -Set Autogeo Geo spell to Frailty')
        notice('indi fury           -Set Autogeo Indi spell to Fury')
        notice('indi haste          -Set Autogeo Indi spell to Haste')
        notice('indi frailty        -Set Autogeo Indi spell to Frailty')
        notice('--------------------------------------------------------------------------')
        notice('invis please        -Whm/Sch will cast AOE invis')
        notice('sneak please        -Whm/Sch will cast AOE sneak')
		notice('assiston            -turns assist on')
		notice('assiststop          -turns assist off')
		notice('assistme            -sets player assist to whom entered command')
		notice('position            -sets new position for autoassist, if return to position is on, repositon should be off but incadse its on')
		notice('foodup              -will toggle gearswap autofood on, currently only works with silindrills luas')
        notice('--------------------------------------------------------------------------')
    else
        warning('Unkown command \''..command..'\', ignored.')

    end
    config.save(settings)
end)

windower.register_event('chat message', function(message, player)
	
	messageTarget = (message):match('[^ ]+$')

	if settings.whitelist:contains(player) then
    	if string.match(message, 'foodup') then
    			windower.send_command('input //gs c toggle autofoodmode '..player)
    	end
    	if string.match(message, 'assiststop') then
    		windower.send_command('input //sm all off')
    	end
    	if string.match(message, 'assiston') then
    		windower.send_command('input //sm all on')
    	end
    	if string.match(message, 'assistme') then
    		windower.send_command('input //aa assist '..player)
    	end
    	if string.match(message, 'position') then
    		windower.send_command('input //aa position '..player)
    	end
    	if string.match(message, 'followme') then
    		windower.send_command('input /follow '..player)
    	end
    	if string.match(message, 'stopfollow') then
    		windower.send_command('setkey numpad7 down; pause1; setkey numpad7 up')
    	end
    	if string.match(message, 'mount') then
    		windower.send_command('input /mount "Raptor" '..player)
    	end
    	if string.match(message, 'dismount') then
    		windower.send_command('input /dismount '..player)
    	end
    	if string.match(message, 'inviteme') and autoinvite == 'on' then
    		windower.send_command('input /refa all;pause 5;input /pcmd add '..player)
    	elseif string.match(message, 'givelead') then
    		windower.send_command('input /partycmd leader '..messageTarget)
    	end
    	if (mainjob =='WHM' or mainjob =='SCH') and sneakinvis == 'on' then
    		if string.match(message, 'invis please') then
    			windower.send_command('input /ja "Light Arts";pause 3;input /ja Accession;pause 3;input /ma invisible <me>')
    		elseif string.match(message, "sneak please") then
    			windower.send_command('input /ja "Light Arts";pause 3;input /ja Accession;pause 3;input /ma sneak <me>')
    		elseif string.match(message, "sneakinvis") then
    			windower.send_command('input /ja "Light Arts";pause 3;input /ja Accession;pause 3;input /ma sneak <me>;pause 6;input /ja Accession;pause 3;input /ma invisible <me>')
    		end
    	end
    	if mainjob =='BRD' and brdcommands == 'on' then
    		if string.match(message, 'stopsongs') then
    			windower.send_command('sing off')
    		elseif string.match(message, 'startsongs') then
    			windower.send_command('sing on')
    		elseif string.match(message, 'fixclarion') then
    			windower.send_command('input /ja "Clarion Call"')
            elseif string.match(message, 'missing song') then
    			windower.send_command('input /ma '..SingleBuffer)
    		end
    	end
        if mainjob =='COR' and corcommands == 'on' then
    		if string.match(message, 'stoprolls') then
    			windower.send_command('cor off')
    		elseif string.match(message, 'startrolls') then
    			windower.send_command('cor on')
    		elseif string.match(message, 'sam and chaos') or string.match(message, 'chaos and sam') then
    			windower.send_command('cor roll 1 sam;cor roll 2 drk')
    		elseif string.match(message, 'sam and cor') or string.match(message, 'cor and sam') then
    			windower.send_command('cor roll 1 sam;cor roll 2 cor')
    		elseif string.match(message, 'cor and chaos') or string.match(message, 'chaos and cor') then
    			windower.send_command('cor roll 1 cor;cor roll 2 drk')
    		end
    	end
        if mainjob =='GEO' and geocommands == 'on' then
            if string.match(message, 'stopgeo') then
                windower.send_command('geo off')
            elseif string.match(message, 'startgeo') then
                windower.send_command('geo on')
            elseif string.match(message, 'geo malaise') then
                windower.send_command('geo geo malaise')
            elseif string.match(message, 'geo frailty') then
                windower.send_command('geo geo frailty')
            elseif string.match(message, 'indi fury') then
                windower.send_command('geo indi fury')
            elseif string.match(message, 'indi haste') then
                windower.send_command('geo indi haste')
            elseif string.match(message, 'indi frailty') then
                windower.send_command('geo indi frailty')
            end
        end
	end
end)
Ftrusts_box = function()
    str = '\\cs(255,100,0) FTrusts\\cr\n'
    str = str..'____________________\\cr\n\n'
    str = str..'\\cs(0,255,0)Autoinvite:   \\cs(255,255,0)	   '..autoinvite..'\\cr\n'
    str = str..'\\cs(0,255,0)COR commands: \\cs(255,255,0)	   '..corcommands..'\\cr\n'
    str = str..'\\cs(0,255,0)BRD commands: \\cs(255,255,0)	   '..brdcommands..'\\cr\n'
    str = str..'\\cs(0,255,0)GEO commands: \\cs(255,255,0)   '..geocommands..'\\cr\n'
    str = str..'\\cs(0,255,0)Sneak/Invis:  \\cs(255,255,0)	   '..sneakinvis..'\\cr\n'
    str = str..'____________________\\cr\n'
    return str
end
Ftrusts_box_config = {pos={x=PosisionX,y=PositionY},bg={visible=true,alpha=40},padding=8,text={font='consolas',size=10,stroke={width=2,alpha=255},Fonts={'consolas'},},flags={draggable=true}}
Ftrusts_jobbox = texts.new(Ftrusts_box_config)

Ftrusts_jobbox:text(Ftrusts_box())
Ftrusts_jobbox:show()