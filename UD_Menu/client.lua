--[======================]--

-- Universal Development Menu
-- Created By: DevDawson
-- Documentation: https://devdawson.xyz/docs/ud-menu

Menu_Name = "UD Menu"
Menu_Subtitle = "Universal Development Menu"
Menu_Key = 244

--[======================]--

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(Menu_Name, Menu_Subtitle)
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled(false)
_menuPool:ControlDisablingEnabled(false)

characterName = "Name Not Set"
characterTwotter = "Handle Not Set"

function CivilianMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Civilian")
    local huItem = NativeUI.CreateItem("Handsup", "Puts your hands up")
    local hukItem = NativeUI.CreateItem("Handsup Knees", "Puts your hands up and knees")
    local SetNameItem = NativeUI.CreateItem("Set Character Name", "Sets your character name")
    local SetTwotterItem = NativeUI.CreateItem("Set Twotter Handle", "Sets your character twotter handle")
    local HandIDItem = NativeUI.CreateItem("Hand ID", "Hands your ID to the specified server ID")
    local TweetItem = NativeUI.CreateItem("Tweet From Twotter", "Tweet from your Twotter account")

    submenu:AddItem(huItem)
    submenu:AddItem(hukItem)
    submenu:AddItem(SetNameItem)
    submenu:AddItem(SetTwotterItem)
    submenu:AddItem(HandIDItem)
    submenu:AddItem(TweetItem)

    huItem.Activated = function(sender, time)
        HU()
        
        exports['mythic_notify']:SendAlert('success', 'Hands Up Executed', 5000)
    end

    hukItem.Activated = function(sender, time)
        ToggleHUK()
        
        exports['mythic_notify']:SendAlert('success', 'Hands Up Knees Executed', 5000)
    end

    SetNameItem.Activated = function(sender, time)
        _menuPool:CloseAllMenus()
        
        SetCharacterName()
    end

    SetTwotterItem.Activated = function(sender, time)
        _menuPool:CloseAllMenus()
        
        SetCharacterTwotter()
    end

    HandIDItem.Activated = function(sender, time)

        if characterName == "Name Not Set" then

            exports['mythic_notify']:SendAlert('error', 'You need to set your Character Name first.', 5000)

        else

            _menuPool:CloseAllMenus()
        
            HandIDShit()

        end

    end

    TweetItem.Activated = function(sender, time)

        if characterTwotter == "Handle Not Set" then

            exports['mythic_notify']:SendAlert('error', 'You need to set your Twotter Handle first.', 5000)

        else
            
            _menuPool:CloseAllMenus()
        
            TweetShit()

        end
        
    end
end

ARRacked = false
ShotRacked = false

function LEOMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "LEO")
    local loadItem = NativeUI.CreateItem("Equip Loadout", "Equips your LEO Loadout")
    local removeItem = NativeUI.CreateItem("Remove Loadout", "Removes all your weapons")
    local bodyArmItem = NativeUI.CreateItem("Equip Body Armor", "Equips body armor to your ped")
    local rackAR = NativeUI.CreateItem("Rack / Unrack AR", "Racks or Unracks your AR")
    local rackShot = NativeUI.CreateItem("Rack / Unrack Shotgun", "Racks or Unracks your Shotgun")
    local radarItem = NativeUI.CreateItem("Toggle Radar", "Opens Radar Menu")

    submenu:AddItem(rackAR)
    submenu:AddItem(rackShot)
    submenu:AddItem(loadItem)
    submenu:AddItem(removeItem)
    submenu:AddItem(bodyArmItem)
    submenu:AddItem(radarItem)

    radarItem.Activated = function(sender, item)
        _menuPool:CloseAllMenus()

        TriggerEvent( 'wk:radarRC' )

        exports['mythic_notify']:SendAlert('success', 'Radar Opened', 5000)
    end

    rackAR.Activated = function(sender, item)

        local pedveh = GetPlayerPed(-1)

        if IsPedInAnyVehicle(pedveh) then
            local car = GetVehiclePedIsIn(pedveh, false)
            if GetVehicleClass( car ) == 18 then
                if (GetPedInVehicleSeat(car, -1) == pedveh) then
                    if ARRacked == false then
                        GiveWeaponToPed(GetPlayerPed(-1), 0x83BF0278, 999, false, true) -- Carbine Rifle
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x83BF0278, 0x7BC4CDDC) --Carbine Rifle Flashlight
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x83BF0278, 0xC164F53) --Carbine Rifle Grip
                        
                        exports['mythic_notify']:SendAlert('success', 'Unracked AR Successful', 5000)
    
                        ARRacked = true
                    else
                        if ARRacked == true then
                            RemoveWeaponFromPed(GetPlayerPed(-1), 0x83BF0278) -- Carbine Rifle
                            
                            exports['mythic_notify']:SendAlert('success', 'Racking AR Successful', 5000)
        
                            ARRacked = false
                        end
                    end
                else
                    if (GetPedInVehicleSeat(car, 0) == pedveh) then
                        if ARRacked == false then
                        GiveWeaponToPed(GetPlayerPed(-1), 0x83BF0278, 999, false, true) -- Carbine Rifle
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x83BF0278, 0x7BC4CDDC) --Carbine Rifle Flashlight
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x83BF0278, 0xC164F53) --Carbine Rifle Grip
                        
                        exports['mythic_notify']:SendAlert('success', 'Unracked AR Successful', 5000)
    
                        ARRacked = true
                        else
                            if ARRacked == true then
                                RemoveWeaponFromPed(GetPlayerPed(-1), 0x83BF0278) -- Carbine Rifle
                            
                                exports['mythic_notify']:SendAlert('success', 'Racking AR Successful', 5000)

                                ARRacked = false
                            end
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', "You're not in the drivers / passenger seat.", 5000)
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', "You're not in a police vehicle.", 5000)
            end
        else
            exports['mythic_notify']:SendAlert('error', "You're not in your vehicle.", 5000)
        end 
        
    end

    rackShot.Activated = function(sender, item)

        local pedveh = GetPlayerPed(-1)

        if IsPedInAnyVehicle(pedveh) then
            local car = GetVehiclePedIsIn(pedveh, false)
            if GetVehicleClass( car ) == 18 then
                if (GetPedInVehicleSeat(car, -1) == pedveh) then
                    if ShotRacked == false then
                        GiveWeaponToPed(GetPlayerPed(-1), 0x1D073A89, 999, false, true)-- Shotgun
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x1D073A89, 0x7BC4CDDC) --Pump Shotgun Flashlight
                        
                        exports['mythic_notify']:SendAlert('success', 'Unracked Shotgun Successful', 5000)
    
                        ShotRacked = true
                    else
                        if ShotRacked == true then
                            RemoveWeaponFromPed(GetPlayerPed(-1), 0x1D073A89) -- Shotgun
                            
                            exports['mythic_notify']:SendAlert('success', 'Racking Shotgun Successful', 5000)
        
                            ShotRacked = false
                        end
                    end
                else
                    if (GetPedInVehicleSeat(car, 0) == pedveh) then
                        if ShotRacked == false then
                        GiveWeaponToPed(GetPlayerPed(-1), 0x1D073A89, 999, false, true)-- Shotgun
                        GiveWeaponComponentToPed(GetPlayerPed(-1), 0x1D073A89, 0x7BC4CDDC) --Pump Shotgun Flashlight
                        
                        exports['mythic_notify']:SendAlert('success', 'Unracked Shotgun Successful', 5000)
    
                        ShotRacked = true
                        else
                            if ShotRacked == true then
                                RemoveWeaponFromPed(GetPlayerPed(-1), 0x1D073A89) -- Shotgun
                            
                                exports['mythic_notify']:SendAlert('success', 'Racking Shotgun Successful', 5000)
        
                                ShotRacked = false
                            end
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', "You're not in the drivers / passenger seat.", 5000)
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', "You're not in a police vehicle.", 5000)
            end
        else
            exports['mythic_notify']:SendAlert('error', "You're not in your vehicle.", 5000)
        end 
        
    end

    loadItem.Activated = function(sender, item)
        if item == loadItem then
            GiveWeaponToPed(GetPlayerPed(-1), 0x5EF9FEC4, 999, false, false) -- Combat Pistol
            GiveWeaponToPed(GetPlayerPed(-1), 0x3656C8C1, 1, false, false) -- Tazer
            GiveWeaponToPed(GetPlayerPed(-1), 0x678B81B1, 1, false, false) -- Night Stick
            GiveWeaponToPed(GetPlayerPed(-1), 0x497FACC3, 25, false, false) -- Flare
            GiveWeaponToPed(GetPlayerPed(-1), 0x8BB05FD7, 1, false, false) -- Flashlight
            GiveWeaponComponentToPed(GetPlayerPed(-1), 0x5EF9FEC4, 0x359B7AAE) --Combat Pistol Flashlight
            
            exports['mythic_notify']:SendAlert('success', 'LEO Loadout Equipped', 5000)
        end
    end

    removeItem.Activated = function(sender, item)
        if item == removeItem then
            RemoveAllPedWeapons(GetPlayerPed(-1), true)

            exports['mythic_notify']:SendAlert('success', 'Loadout Removed', 5000)
        end
    end


    bodyArmItem.Activated = function(sender, item)
        if item == bodyArmItem then
            SetEntityHealth(PlayerPedId(), 200)
            SetPedArmour(GetPlayerPed(-1), 100)

            exports['mythic_notify']:SendAlert('success', 'Body Armor Equipped', 5000)        
        end
    end



    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)

end

doors = {
    "Front Left",
    "Front Right",
    "Back Left",
    "Back Right",
    "Hood",
    "Trunk"
}

windows = {
    "Front Left",
    "Front Right",
    "Back Left",
    "Back Right"
}

function VehicleMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Vehicle")
    local engineItem = NativeUI.CreateItem("Toggle Engine", "Toggles your engine on / off")
    local doorItem = NativeUI.CreateListItem("Door Control", doors, 1, "Opens / Closes Vehicle Doors")
    local windowItem = NativeUI.CreateListItem("Window Control", windows, 1, "Rolls Up / Down Vehicle Windows")

    submenu:AddItem(engineItem)
    submenu:AddItem(doorItem)
    submenu:AddItem(windowItem)

    engineItem.Activated = function(sender, item)
        if item == engineItem then
            vehicleEngine()
        end
    end

    submenu.OnListSelect = function(sender, item, index)
        if item == doorItem then
            local selectedDoor = item:IndexToItem(index)
            doorCtrl(selectedDoor)
        end

        if item == windowItem then
            local selectedWindow = item:IndexToItem(index)
            windowCtrl(selectedWindow)
        end
    end

    _menuPool:MouseControlsEnabled(false)
    _menuPool:ControlDisablingEnabled(false)

end

LEOMenu(mainMenu)
CivilianMenu(mainMenu)
VehicleMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, Menu_Key) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)

-- [ Functions ] --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if ARRacked then
            if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_carbinerifle") then
            else
                if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                else
                    GiveWeaponToPed(GetPlayerPed(-1), 0x83BF0278, 0, false, true)
                end
            end
        else
            if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_carbinerifle") then
                RemoveWeaponFromPed(GetPlayerPed(-1), 0x83BF0278)
                exports['mythic_notify']:SendAlert('inform', "You're not allowed to use the carbine rifle / M4A1, you must unrack it.", 5000)
            end 
        end

        if ShotRacked then
            if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_pumpshotgun") then
            else
                if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                else
                    GiveWeaponToPed(GetPlayerPed(-1), 0x1D073A89, 0, false, true)
                end
            end
        else
            if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_pumpshotgun") then
                RemoveWeaponFromPed(GetPlayerPed(-1), 0x1D073A89)
                exports['mythic_notify']:SendAlert('inform', "You're not allowed to use the pump shotgun / less lethal shotgun, you must unrack it.", 5000)
            end 
        end
    end
end)

function LocalPed()
    return GetPlayerPed(PlayerId())  
end

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function HU()

	if DoesEntityExist(LocalPed()) then
		Citizen.CreateThread(function()
			RequestAnimDict("random@getawaydriver")
			while not HasAnimDictLoaded("random@getawaydriver") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(LocalPed(), "random@getawaydriver", "idle_2_hands_up", 3) then
				ClearPedSecondaryTask(LocalPed())
			else
				TaskPlayAnim(LocalPed(), "random@getawaydriver", "idle_2_hands_up", 8.0, -8, -1, 50, 0, 0, 0, 0)
			end		
		end)
	end
end
	
function ToggleHUK()
	if DoesEntityExist(LocalPed()) then
		RequestAnimDict("random@arrests")
		while not HasAnimDictLoaded("random@arrests") do
			Citizen.Wait(100)
        end
            
        RequestAnimDict("random@arrests@busted")
		while not HasAnimDictLoaded("random@arrests@busted") do
			Citizen.Wait(100)
		end
			
		if IsEntityPlayingAnim(LocalPed(), "random@arrests@busted", "idle_a", 3) then
            TaskPlayAnim(LocalPed(), "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Citizen.Wait(3000)
            TaskPlayAnim(LocalPed(), "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
		else
			TaskPlayAnim( LocalPed(), "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Citizen.Wait(4000)
            TaskPlayAnim( LocalPed(), "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Citizen.Wait(1000)
            TaskPlayAnim( LocalPed(), "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
            Citizen.Wait(1000)
            TaskPlayAnim( LocalPed(), "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
		end		
	end
end

function SetCharacterName()
    Citizen.CreateThread( function()
        DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 48 )

        while true do 
            if ( UpdateOnscreenKeyboard() == 1 ) then 
                local CharacterNames = GetOnscreenKeyboardResult()
                characterName = CharacterNames
                exports['mythic_notify']:SendAlert('success', 'Character Name Set ' .. CharacterNames, 5000)
                break
            elseif ( UpdateOnscreenKeyboard() == 2 ) then 
                break 
            end  

            Citizen.Wait( 0 )
        end 
    end )
end

function SetCharacterTwotter()
    Citizen.CreateThread( function()
        DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 48 )

        while true do 
            if ( UpdateOnscreenKeyboard() == 1 ) then 
                local CharacterTwotters = GetOnscreenKeyboardResult()
                characterTwotter = CharacterTwotters
                exports['mythic_notify']:SendAlert('success', 'Character Twotter Set @' .. CharacterTwotters, 5000)
                break
            elseif ( UpdateOnscreenKeyboard() == 2 ) then 
                break 
            end  

            Citizen.Wait( 0 )
        end 
    end )
end

function HandIDShit()

    Citizen.CreateThread( function()
        DisplayOnscreenKeyboard( false, "", "", "Server ID", "", "", "", 48 )

        while true do 
            if ( UpdateOnscreenKeyboard() == 1 ) then 
                local serverIDResult = GetOnscreenKeyboardResult()

                TriggerServerEvent("Menu:HandID", serverIDResult, "Full Name | " .. characterName)
                exports['mythic_notify']:SendAlert('success', 'ID Handed to Server ID: ' .. serverIDResult)

                break
            elseif ( UpdateOnscreenKeyboard() == 2 ) then 
                break 
            end  

            Citizen.Wait( 0 )
        end 
    end )

end

function TweetShit()

    Citizen.CreateThread( function()
        DisplayOnscreenKeyboard( false, "", "", "", "", "", "", 128 )

        while true do 
            if ( UpdateOnscreenKeyboard() == 1 ) then 
                local tweetResult = GetOnscreenKeyboardResult()

                TriggerServerEvent("Menu:Tweet", characterTwotter, tweetResult)
                TriggerServerEvent("Menu:TweetNotify", characterTwotter)

                break
            elseif ( UpdateOnscreenKeyboard() == 2 ) then 
                break 
            end  

            Citizen.Wait( 0 )
        end 
    end )

end

function vehicleEngine()

    local veh = GetVehiclePedIsIn(LocalPed(), false)

    if IsPedInAnyVehicle(LocalPed()) == false then
        exports['mythic_notify']:SendAlert('error', "You're not in a vehicle")
    else

        if (GetPedInVehicleSeat(veh, -1) == LocalPed()) then

            if GetIsVehicleEngineRunning(veh) then
                SetVehicleEngineOn(veh, false, false)
                SetVehicleUndriveable(veh, true)
                exports['mythic_notify']:SendAlert('success', "Engine Turned Off")
            else
                SetVehicleEngineOn(veh, true, false)
                SetVehicleUndriveable(veh, false)
                exports['mythic_notify']:SendAlert('success', "Engine Turned On")
            end

        else
            exports['mythic_notify']:SendAlert('error', "You're not in the drivers seat")
        end

    end

end

function doorCtrl(door)

    if door == "Front Left" then
        neededDoor = 0
    elseif door == "Front Right" then
        neededDoor = 1
    elseif door == "Back Left" then
        neededDoor = 2
    elseif door == "Back Right" then
        neededDoor = 3
    elseif door == "Hood" then
        neededDoor = 4
    elseif door == "Trunk" then
        neededDoor = 5
    end

    local veh = GetVehiclePedIsIn(LocalPed(), false)

    if IsPedInAnyVehicle(LocalPed()) == false then
        exports['mythic_notify']:SendAlert('error', "You're not in a vehicle")
    else

        if (GetPedInVehicleSeat(veh, -1) == LocalPed()) then

            local doorAngle = GetVehicleDoorAngleRatio(veh, neededDoor)

            if doorAngle > 0 then
                SetVehicleDoorShut(veh, neededDoor, false, false)
                exports['mythic_notify']:SendAlert('success', door .. " Door Shut")
            else
                SetVehicleDoorOpen(veh, neededDoor, false, false)
                exports['mythic_notify']:SendAlert('success', door .. " Door Opened")
            end

        end

    end

end

FLwin = true
FRwin = true
BLwin = true
BRwin = true

function windowCtrl(window)

    local veh = GetVehiclePedIsIn(LocalPed(), false)

    if IsPedInAnyVehicle(LocalPed()) == false then
        exports['mythic_notify']:SendAlert('error', "You're not in a vehicle")
    else

        if (GetPedInVehicleSeat(veh, -1) == LocalPed()) then

            if window == "Front Left" then
                if FLwin then
                    RollDownWindow(veh, 0)
                    FLwin = false
                else
                    RollUpWindow(veh, 0)
                    FLwin = true
                end
            elseif window == "Front Right" then
                if FRwin then
                    RollDownWindow(veh, 1)
                    FRwin = false
                else
                    RollUpWindow(veh, 1)
                    FRwin = true
                end
            elseif window == "Back Left" then
                if BLwin then
                    RollDownWindow(veh, 2)
                    BLwin = false
                else
                    RollUpWindow(veh, 2)
                    BLwin = true
                end
            elseif window == "Back Right" then
                if BRwin then
                    RollDownWindow(veh, 3)
                    BRwin = false
                else
                    RollUpWindow(veh, 3)
                    BRwin = true
                end
            end

        end

    end

end

RegisterNetEvent('HandIDDisplay')
AddEventHandler('HandIDDisplay', function(inputText)

	SetNotificationTextEntry('STRING');
	AddTextComponentString(inputText);
	SetNotificationMessage("CHAR_FLOYD", "dmv", true, 4, "DMV", "Drivers License");
	DrawNotification(false, true);
end)

RegisterNetEvent('TweetNotify')
AddEventHandler('TweetNotify', function(handle)

	SetNotificationTextEntry('STRING');
	AddTextComponentString("New Tweet from @" .. handle);
	SetNotificationMessage("CHAR_FLOYD", "tweet", true, 4, "Twotter", "New Tweet Notification");
	DrawNotification(false, true);
end)