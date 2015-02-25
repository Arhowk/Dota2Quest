local function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

QuestGenerator = {name = "",
				minLevel = 0,
				active = false,
				minLevel = 0,
				maxPartySize = 2,
				minPartySize = 0,
				stages = {},
				starters = {},
				activeStage = {},
				bounty = {},
				prereqs = {}}

QuestGenerator.__index = QuestGenerator

--QuickClass(QuestGenerator);

function QuestGenerator.new(name) 
    o = {}
    setmetatable(o, QuestGenerator)
    return o
    --[[for k,v in pairs(o) do
       print(k, v) 
    end]]
end
function QuestGenerator:nextStage()
	table.insert(self.stages, self.activeStage)
	self.activeStage = {}
end
function QuestGenerator.parseQuest(fileName)
	o = LoadKeyValues(fileName) 
	setmetatable(o, QuestGenerator)
	return o
end
function QuestGenerator:addInteractStarter(widg)
    table.insert(self.starters, {type="interact",
    								widget=widg})
end
function QuestGenerator:addPrereq(func, hint)
	table.insert(self.prereqs, {type="trigger", target=func, hint=hint})
end
function QuestGenerator:addInteract(identifier,hint, pings)
	table.insert(self.activeStage, {type="interact", target=identifier})
end
function QuestGenerator:addInteractType(type,hint, pings)
	table.insert(self.activeStage, {type="interactType", target=type})
end
function QuestGenerator:addKill(identifier, hint, count, pings)
    table.insert(self.activeStage, {type="kill", target=identifier, count=count})
end
function QuestGenerator:addKillType(id, count,hint,pings)
    table.insert(self.activeStage, {type="killType", target=id, count=count})
end
function QuestGenerator:addItem(identifier, count, hint,pings)
    table.insert(self.activeStage, {type="item", target=identifier, count=count})
end
function QuestGenerator:addItemType(id, count, hint,pings)
    table.insert(self.activeStage, {type="interactType", target=type})
end
function QuestGenerator:addItemTurnin(identifier, count, target, hint,pings)
    table.insert(self.activeStage, {type="item", target=identifier, count=count, reciever=target})
end
function QuestGenerator:addItemTypeTurnin(id, count, target, hint,pings)
    table.insert(self.activeStage, {type="interactType", target=type, reciever=target})
end
function QuestGenerator:addFuncRun(func)
    table.insert(self.activeStage, {type="func", target=func})
end
function QuestGenerator:addFuncRunIfDestroyed(func)
    table.insert(self.activeStage, {type="funcDestroyed", target=func})
end
--tieToPrev : disables the ping if the objective instantiated before was finished
function QuestGenerator:addFinish()
    table.insert(self.stages, self.activeStage)
    self.activeStage = {}
end
--hint: bounties dont need to be done at finish
function QuestGenerator:addUnitBounty(type, count)
    table.insert(self.activeStage, {type="unitBounty", target=type, count=count})
end
function QuestGenerator:addItemBounty(type, count)
    table.insert(self.activeStage, {type="itemBounty", target=type, count=count})
end
function QuestGenerator:addGoldBounty(amount)
    table.insert(self.activeStage, {type="goldBounty", count=amount})
end
function QuestGenerator:addWoodBounty(amount)
    table.insert(self.activeStage, {type="woodBounty", count=amount})
end
function QuestGenerator:addQuestStartBounty(questId)
    
end
function QuestGenerator:addQuestEnableBounty(questId)
    
end
function QuestGenerator:onTransition(text)
	table.insert(self.activeStage, {type="onTransition", text=text})
end

function QuestGenerator:setMinLevel(lvl)
    self.minLevel = lvl
end
function demo()
	a = QuestGenerator.new("TesttyTestty");
	print("Max Party Size" .. a.maxPartySize)
	PrintTable(a)
	a:addPrereq(function(player)
					print("Hello from the world of prerequisites");
					return true
				end, "Yous isn't sexy enough")
	a:addKill("flag_destinedtodie", "Kill the King of Funk")
	a:nextStage()
	a:onTransition("LOLOLOLOLOL")
	a:addKill("flag_destinedtodie", "Kill the King of Funk. AGAIN!")
	a:addGoldBounty(1000)
	a:addFinish()
	a:addItemBounty("item_belt_of_strength", "2")
	PrintTable(a)
end
demo()
b = QuestGenerator.parseQuest("scripts/vscripts/quest/sampleQuest.txt");
PrintTable(b)