--THIS IS NOT THE ONLY SCRIPT YOU NEED INSERT THIS MODEL INTO THE GAME: https://create.roblox.com/marketplace/asset/12347574842/to-roblox-ban-bot
local API = require(game.ServerScriptService:WaitForChild("TrelloAPI"))
local BanBoardId = API:GetBoardID("robloxto")
local BanListID = API:GetListID("bans",BanBoardId)
local banmsg = 'You are banned from this game'
local servermsgalert = game.ReplicatedStorage:WaitForChild('msgevent')


function checkCurrentPlayersforban()
	while wait(3) do
		local bancards = API:GetCardsInList(BanListID)
		for _, Player in pairs(game.Players:GetChildren()) do
			for _, Card in pairs(bancards) do
				if string.find(Card.name, Player.UserId) then
					servermsgalert:FireAllClients('The ban hammer has spoken!')
					Player:Destroy()
					servermsgalert:FireAllClients(Player.." Was permanently banned!")
				end
			end
		end
	end
end

spawn(checkCurrentPlayersforban)

game.Players.PlayerAdded:Connect(function(plr)
	local bancards = API:GetCardsInList(BanListID)
	for _, Card in pairs(bancards) do
		if string.find(Card.name, plr.UserId) then
			print('1')
			plr:Kick('PERMBANNED You are permanently banned from all servers!')
		end
	end
end)
