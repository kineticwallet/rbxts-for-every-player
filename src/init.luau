--!strict
--!optimize 2

--[[
$$\       $$\                      $$\     $$\                                   $$\ $$\            $$\
$$ |      \__|                     $$ |    \__|                                  $$ |$$ |           $$ |
$$ |  $$\ $$\ $$$$$$$\   $$$$$$\ $$$$$$\   $$\  $$$$$$$\ $$\  $$\  $$\  $$$$$$\  $$ |$$ | $$$$$$\ $$$$$$\
$$ | $$  |$$ |$$  __$$\ $$  __$$\\_$$  _|  $$ |$$  _____|$$ | $$ | $$ | \____$$\ $$ |$$ |$$  __$$\\_$$  _|
$$$$$$  / $$ |$$ |  $$ |$$$$$$$$ | $$ |    $$ |$$ /      $$ | $$ | $$ | $$$$$$$ |$$ |$$ |$$$$$$$$ | $$ |
$$  _$$<  $$ |$$ |  $$ |$$   ____| $$ |$$\ $$ |$$ |      $$ | $$ | $$ |$$  __$$ |$$ |$$ |$$   ____| $$ |$$\
$$ | \$$\ $$ |$$ |  $$ |\$$$$$$$\  \$$$$  |$$ |\$$$$$$$\ \$$$$$\$$$$  |\$$$$$$$ |$$ |$$ |\$$$$$$$\  \$$$$  |
\__|  \__|\__|\__|  \__| \_______|  \____/ \__| \_______| \_____\____/  \_______|\__|\__| \_______|  \____/
]]
--

-- >>SERVICES<< -
local Players: Players = game:GetService("Players")

-- >>CORE<< --
return function(addedCallback: (player: Player) -> unknown?, removingCallback: (player: Player) -> unknown?): ()
	-- Created silenced variables for the oberserved callback.
	local addedConnection: RBXScriptConnection? = nil
	local removingConnection: RBXScriptConnection? = nil

	-- Check if the added callback is valid.
	if typeof(addedCallback) == "function" then
		-- Set callback connection and connect to PlayerAdded event.
		addedConnection = Players.PlayerAdded:Connect(addedCallback :: (player: Player) -> unknown)
		-- Iterate over all active players and spawn a new task with the given callback.
		for _: number, player: Player in ipairs(Players:GetPlayers()) do
			task.spawn(addedCallback, player)
		end
	end

	-- Check if the removing callback is valid.
	if typeof(removingCallback) == "function" then
		-- Set callback connection and connect to PlayerRemoving event.
		removingConnection = Players.PlayerRemoving:Connect(removingCallback :: (player: Player) -> unknown)
	end

	-- Return function for observer behaviour.
	return function()
		-- Disconnect added connection in case it exists.
		if typeof(addedConnection) == "RBXScriptConnection" then
			(addedConnection :: RBXScriptConnection):Disconnect()
		end
		-- Disconnect removing connection in case it exists.
		if typeof(removingConnection) == "RBXScriptConnection" then
			(removingConnection :: RBXScriptConnection):Disconnect()
		end
	end
end
