RegisterServerEvent("Menu:HandID")
AddEventHandler("Menu:HandID", function(person, text)
    TriggerClientEvent("HandIDDisplay", person, text)
end)

RegisterServerEvent("Menu:Tweet")
AddEventHandler("Menu:Tweet", function(handle, content)
    TriggerClientEvent('chatMessage', -1, "^7[^5Twotter^7] ^5@^7" .. handle .." ^5[^7" .. source .. "^5]^7: " .. content)
end)

RegisterServerEvent("Menu:TweetNotify")
AddEventHandler('Menu:TweetNotify', function(handle)
	TriggerClientEvent('TweetNotify', -1, handle)
end)