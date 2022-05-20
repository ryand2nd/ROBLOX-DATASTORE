local dataStoreService = game:GetService("DataStoreService")
local myData = dataStoreService:GetDataStore("Data") -- "Data" is your data Name

local function saveData(player)
	
	local saveTable = {
		player.leaderstats.Money.Value; -- Change "Money" to your Currency (Below at PlayerAdded)
		player.leaderstats.Rebirth.Value; -- Change "Rebirth" to your Currency (Below at PlayerAdded)
		-- Add more if you have more Currency
	}	
	
	-- Do not change this
	local s, err = pcall(function()
		myData:SetAsync(player.UserId, saveTable)
	end)
	
	if s then
		print("Data Saved!")
	else
		print("Data Can't Saved!")
		warn(err)
	end
	
end

-- Do not change this
game.Players.PlayerRemoving:Connect(function(plr)
	saveData(plr)
end)

-- Do not change this
game:BindToClose(function()
	for _,v in pairs(game.Players:GetPlayers()) do
		saveData(v)
	end
end)

game.Players.PlayerAdded:Connect(function(plr)
	local stats = Instance.new("Folder",plr)
	stats.Name = "leaderstats"
	
	local money = Instance.new("IntValue",stats) -- Change the name to whatever you want and change the saveTable above too
	money.Name = "Money" 
	
	local rebirth = Instance.new("IntValue",stats) -- Change the name to whatever you want and change the saveTable above too
	rebirth.Name = "Rebirth"
	
	-- Do not change this
	local data
	local s, err = pcall(function()
		data = myData:GetAsync(plr.UserId)
	end)
	
	if s and data then
		money.Value = data[1] -- Change "money" to your currency
		rebirth.Value = data[2] -- Change "money" to your currency
		-- Add more if you have other currency
	else
		print("Player has no data")
	end
end)
